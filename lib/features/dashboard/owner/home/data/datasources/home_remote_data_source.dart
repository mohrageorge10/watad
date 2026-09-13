import 'package:watad/core/errors/error_model.dart';
import 'package:watad/core/errors/exceptions.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/features/dashboard/owner/home/data/models/current_project_overview_model.dart';
import 'package:watad/features/dashboard/owner/home/data/models/paginated_projects_model.dart';
import 'package:watad/features/dashboard/owner/home/data/models/project_summary_model.dart';
import 'package:watad/features/dashboard/owner/home/data/models/owner_profile_model.dart';


abstract class HomeRemoteDataSource {
  Future<CurrentProjectOverviewModel> getCurrentProjectOverview();

  Future<PaginatedProjectsModel> getOwnerProjects({
    int? status,
    required int pageNumber,
    required int pageSize,
  });

  Future<OwnerProfileModel> getOwnerProfile();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  const HomeRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CurrentProjectOverviewModel> getCurrentProjectOverview() async {
    final response = await apiConsumer.get(EndPoints.currentProjectOverview);
    final json = _extractData(response);
    return CurrentProjectOverviewModel.fromJson(json);
  }

  @override
  Future<OwnerProfileModel> getOwnerProfile() async {
    final response = await apiConsumer.get(EndPoints.ownerProfile);
    final json = _extractData(response);
    return OwnerProfileModel.fromJson(json);
  }

  @override
  Future<PaginatedProjectsModel> getOwnerProjects({
    int? status,
    required int pageNumber,
    required int pageSize,
  }) async {
    final response = await apiConsumer.get(
      EndPoints.ownerProjects,
      queryParameters: {
        'Status': ?status,
        'PageNumber': pageNumber,
        'PageSize': pageSize,
      },
    );
    
    final map = response as Map<String, dynamic>;
    final isSuccess = map['isSuccess'] as bool? ?? false;
    if (!isSuccess) {
      throw ServerException(ErrorModel.fromJson(map));
    }

    final data = map['data'];
    if (data == null) {
      return const PaginatedProjectsModel(
        items: [], currentPage: 1, totalPages: 1, pageSize: 0, totalCount: 0, hasPrevious: false, hasNext: false,
      );
    }
    
    if (data is List) {
      return PaginatedProjectsModel(
        items: data.map((e) => ProjectSummaryModel.fromJson(e as Map<String, dynamic>)).toList().cast<ProjectSummaryModel>(),
        currentPage: 1,
        totalPages: 1,
        pageSize: data.length,
        totalCount: data.length,
        hasPrevious: false,
        hasNext: false,
      );
    }

    return PaginatedProjectsModel.fromJson(data as Map<String, dynamic>);
  }

  /// { isSuccess, data, message, statusCode }
  Map<String, dynamic> _extractData(dynamic response) {
    final map = response as Map<String, dynamic>;
    final isSuccess = map['isSuccess'] as bool? ?? false;
    if (!isSuccess) {
      throw ServerException(ErrorModel.fromJson(map));
    }
    return (map['data'] as Map<String, dynamic>?) ?? {};
  }
}
