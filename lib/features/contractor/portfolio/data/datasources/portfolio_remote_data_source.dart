import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';

abstract class PortfolioRemoteDataSource {
  Future<List<PortfolioItemModel>> fetchContractorPortfolio();

  Future<List<PortfolioProjectItemModel>> getPortfolioProjects({
    required String contractorId,
  });

  Future<PortfolioProjectItemModel> addPortfolioProject({
    required Map<String, dynamic> projectData,
  });

  Future<PortfolioProjectItemModel> updatePortfolioProject({
    required String projectId,
    required Map<String, dynamic> projectData,
  });

  Future<PortfolioProjectItemModel> getPortfolioProjectDetails({
    required String projectId,
  });

  Future<bool> deletePortfolioProject({
    required String projectId,
  });
}

class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  PortfolioRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.secureStorage,
    required this.cacheHelper,
  });

  Future<Map<String, dynamic>> _getHeaders() async {
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);
    return <String, dynamic>{
      if (token != null && token.isNotEmpty)
        ApiKey.authorization: ApiKey.bearer(token),
    };
  }

  @override
  Future<List<PortfolioItemModel>> fetchContractorPortfolio() async {
    try {
      final headers = await _getHeaders();
      List<PortfolioItemModel> list = [];

      try {
        final response = await apiConsumer.get(
          EndPoints.contractorPortfolio,
          headers: headers,
        );

        if (response is List) {
          list = response
              .map((item) =>
                  PortfolioItemModel.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (response is Map<String, dynamic>) {
          final dynamic data = response[ApiKey.data] ??
              response['items'] ??
              response['portfolio'] ??
              response['portfolioItems'];
          if (data is List) {
            list = data
                .map((item) =>
                    PortfolioItemModel.fromJson(item as Map<String, dynamic>))
                .toList();
          }
        }
      } catch (_) {}

      if (list.isEmpty) {
        // Fallback: check profile endpoint which returns portfolioItems
        try {
          final profileResp = await apiConsumer.get(
            EndPoints.contractorProfile,
            headers: headers,
          );
          if (profileResp is Map<String, dynamic>) {
            final pData = profileResp[ApiKey.data] ?? profileResp;
            if (pData is Map<String, dynamic> &&
                pData['portfolioItems'] is List) {
              final pList = pData['portfolioItems'] as List;
              list = pList
                  .map((item) =>
                      PortfolioItemModel.fromJson(item as Map<String, dynamic>))
                  .toList();
            }
          }
        } catch (_) {}
      }

      // Attach cached local images if server returned empty mediaUrls
      final List<PortfolioItemModel> resolvedList = [];
      for (final p in list) {
        if (p.mediaUrls.isEmpty && p.id.isNotEmpty) {
          final cached =
              cacheHelper.getData(key: 'portfolio_images_${p.id}') as String?;
          if (cached != null && cached.isNotEmpty) {
            try {
              final decoded = jsonDecode(cached);
              if (decoded is List && decoded.isNotEmpty) {
                final strList = decoded.map((e) => e.toString()).toList();
                resolvedList.add(p.copyWith(
                  mediaUrls: strList,
                  image: strList.first,
                ));
                continue;
              }
            } catch (_) {}
          }
        }
        resolvedList.add(p);
      }

      return resolvedList;
    } catch (_) {
      return const [];
    }
  }

  @override
  Future<List<PortfolioProjectItemModel>> getPortfolioProjects({
    required String contractorId,
  }) async {
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    if (token != null && token.isNotEmpty) {
      try {
        final result = await fetchContractorPortfolio();
        return result;
      } catch (_) {
        return const [];
      }
    }

    return const [];
  }

  Future<FormData> _buildFormData(Map<String, dynamic> projectData) async {
    final formData = FormData();

    // The key used to store photos in this map (add='Photos', update='NewPhotos')
    const imageKeys = {'Photos', 'NewPhotos', 'photos', 'newphotos'};

    for (final entry in projectData.entries) {
      if (imageKeys.contains(entry.key)) continue;
      if (entry.value != null && entry.value is! List) {
        formData.fields.add(MapEntry(entry.key, entry.value.toString()));
      }
    }

    // Determine the multipart field name: 'Photos' for add, 'NewPhotos' for update
    final String imageFieldName =
        projectData.containsKey('NewPhotos') ? 'NewPhotos' : 'Photos';
    final rawMedia = projectData[imageFieldName] ?? [];

    if (rawMedia is List) {
      for (final item in rawMedia) {
        final str = item.toString();
        final file = File(str);
        if (file.existsSync()) {
          final fileName =
              str.split(Platform.pathSeparator).last.split('/').last;
          formData.files.add(
            MapEntry(
              imageFieldName,
              await MultipartFile.fromFile(file.path, filename: fileName),
            ),
          );
        } else if (str.startsWith('http://') || str.startsWith('https://')) {
          // For existing URL images, send as ExistingMediaUrls
          formData.fields.add(MapEntry('ExistingMediaUrls', str));
        }
      }
    }

    return formData;
  }

  @override
  Future<PortfolioProjectItemModel> addPortfolioProject({
    required Map<String, dynamic> projectData,
  }) async {
    final headers = await _getHeaders();
    final formData = await _buildFormData(projectData);

    final response = await apiConsumer.post(
      EndPoints.addPortfolioProject,
      data: formData,
      headers: headers.isNotEmpty ? headers : null,
    );

    // rawMedia comes from 'Photos' key (the correct backend field name)
    final rawMedia = projectData['Photos'] ?? projectData['NewPhotos'] ?? [];

    if (response is Map<String, dynamic>) {
      final isSuccess = response[ApiKey.isSuccess] == true ||
          response['statusCode'] == 200 ||
          response['statusCode'] == 201;
      final data = response[ApiKey.data];
      if (data is Map<String, dynamic>) {
        final parsed = PortfolioProjectItemModel.fromJson(data);
        if (parsed.mediaUrls.isEmpty && rawMedia is List && rawMedia.isNotEmpty) {
          final mediaList = rawMedia.map((e) => e.toString()).toList();
          final withMedia = parsed.copyWith(
            mediaUrls: mediaList,
            image: mediaList.first,
          );
          if (parsed.id.isNotEmpty) {
            await cacheHelper.saveData(
              key: 'portfolio_images_${parsed.id}',
              value: jsonEncode(mediaList),
            );
          }
          return withMedia;
        }
        return parsed;
      } else if (isSuccess) {
        // Build a fallback model from the request data so UI updates immediately
        return PortfolioProjectItemModel(
          id: response['id']?.toString() ??
              'proj_${DateTime.now().millisecondsSinceEpoch}',
          title: projectData['title']?.toString() ?? '',
          description: projectData['description']?.toString() ?? '',
          location: projectData['location']?.toString() ?? '',
          price: 'EGP ${projectData['projectCost'] ?? 0}',
          date: projectData['completionDate']?.toString() ?? '',
          image: (rawMedia is List && rawMedia.isNotEmpty)
              ? rawMedia.first.toString()
              : '',
          mediaUrls: rawMedia is List
              ? rawMedia.map((e) => e.toString()).toList()
              : [],
          projectCost: (projectData['projectCost'] as num?)?.toDouble(),
          badgeText: 'Completed',
          badgeType: 'success',
        );
      }
    }

    throw Exception('Failed to add portfolio project');
  }


  @override
  Future<PortfolioProjectItemModel> updatePortfolioProject({
    required String projectId,
    required Map<String, dynamic> projectData,
  }) async {
    final headers = await _getHeaders();
    final formData = await _buildFormData(projectData);

    final response = await apiConsumer.put(
      EndPoints.updatePortfolioProject(projectId),
      data: formData,
      headers: headers.isNotEmpty ? headers : null,
    );

    if (response is Map<String, dynamic>) {
      final isSuccess = response[ApiKey.isSuccess] == true ||
          response['statusCode'] == 200 ||
          response['statusCode'] == 201;
      final data = response[ApiKey.data];
      if (data is Map<String, dynamic>) {
        return PortfolioProjectItemModel.fromJson(data);
      } else if (response.containsKey('title') ||
          response.containsKey('Title') ||
          response.containsKey('id')) {
        return PortfolioProjectItemModel.fromJson(response);
      } else if (isSuccess) {
        final merged = Map<String, dynamic>.from(projectData)
          ..['id'] = projectId;
        return PortfolioProjectItemModel.fromJson(merged);
      }
    }

    throw Exception('Failed to update portfolio project');
  }

  @override
  Future<PortfolioProjectItemModel> getPortfolioProjectDetails({
    required String projectId,
  }) async {
    final headers = await _getHeaders();
    final response = await apiConsumer.get(
      EndPoints.portfolioProject(projectId),
      headers: headers.isNotEmpty ? headers : null,
    );

    if (response is Map<String, dynamic>) {
      final data = response[ApiKey.data] ?? response;
      if (data is Map<String, dynamic>) {
        return PortfolioProjectItemModel.fromJson(data);
      }
    }

    throw Exception('Portfolio project not found');
  }

  @override
  Future<bool> deletePortfolioProject({
    required String projectId,
  }) async {
    final headers = await _getHeaders();
    await apiConsumer.delete(
      EndPoints.portfolioProject(projectId),
      headers: headers.isNotEmpty ? headers : null,
    );
    return true;
  }
}
