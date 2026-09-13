import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';

class ContractorProfileModel extends ContractorProfileEntity {
  const ContractorProfileModel({
    required super.id,
    required super.name,
    required super.companyName,
    required super.rating,
    required super.reviewsCount,
    required super.isVerified,
    required super.yearsOfExperience,
    required super.projectsCompiled,
    required super.verificationStatus,
    required super.commercialRegister,
    required super.taxCard,
    required super.aboutMe,
    required super.specializations,
    required super.coveredGovernorates,
    required super.portfolioImages,
    super.portfolioProjects = const [],
    super.profileImagePath,
    super.isCompleted,
  });

  factory ContractorProfileModel.fromJson(Map<String, dynamic> json) {
    final parsedProjects = _parsePortfolioProjects(json);
    final rawCount = json['projectsCompiled']?.toString() ??
        json['completedProjectsCount']?.toString();
    final compiledCount = (rawCount != null && rawCount.isNotEmpty && rawCount != '0')
        ? rawCount
        : (parsedProjects.isNotEmpty ? parsedProjects.length.toString() : '0');

    return ContractorProfileModel(
      id: json['id']?.toString() ?? json['userId']?.toString() ?? '',
      name: json['name'] as String? ?? json['fullName'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      rating: (json['ratingAverage'] as num?)?.toDouble() ??
          (json['rating'] as num?)?.toDouble() ??
          0.0,
      reviewsCount: json['reviewsCount'] as int? ?? 0,
      isVerified: json['isVerified'] as bool? ??
          (json['verificationStatus']?.toString().toLowerCase() == 'verified'),
      yearsOfExperience: json['yearsOfExperience']?.toString() ?? '',
      projectsCompiled: compiledCount,
      verificationStatus: json['verificationStatus'] as String? ?? '',
      commercialRegister: json['commercialRegister'] as String? ??
          json['commercialRegistrationNumber'] as String? ??
          '',
      taxCard: json['taxCard'] as String? ?? json['taxNumber'] as String? ?? '',
      aboutMe: json['bio'] as String? ??
          json['aboutMe'] as String? ??
          json['description'] as String? ??
          '',
      specializations: _parseListOrDelimitedString(
          json['specialization'] ?? json['specializations']),
      coveredGovernorates:
          _parseListOrDelimitedString(json['coveredGovernorates']),
      portfolioImages: _parsePortfolioImages(json),
      portfolioProjects: parsedProjects,
      profileImagePath: json['profileImagePath'] as String? ??
          json['profileImage'] as String? ??
          json['imageUrl'] as String?,
      isCompleted: json['isCompleted'] as bool? ??
          json['isProfileCompleted'] as bool? ??
          json['isProfileComplete'] as bool?,
    );
  }

  static List<PortfolioProjectItemModel> _parsePortfolioProjects(
      Map<String, dynamic> json) {
    final List<PortfolioProjectItemModel> list = [];
    final rawItems =
        json['portfolioItems'] ?? json['portfolioProjects'] ?? json['projects'];
    if (rawItems is List) {
      for (final item in rawItems) {
        if (item is Map<String, dynamic>) {
          list.add(PortfolioProjectItemModel.fromJson(item));
        } else if (item is Map) {
          list.add(PortfolioProjectItemModel.fromJson(
              Map<String, dynamic>.from(item)));
        }
      }
    }
    return list;
  }

  static List<String> _parsePortfolioImages(Map<String, dynamic> json) {
    final List<String> images = [];

    final rawImages =
        json['portfolioImages'] ?? json['images'] ?? json['portfolio'];
    if (rawImages is List) {
      for (final item in rawImages) {
        if (item is String && item.isNotEmpty) {
          images.add(item);
        } else if (item is Map) {
          final img =
              item['imageUrl'] ?? item['image'] ?? item['coverImage'];
          if (img != null && img.toString().isNotEmpty) {
            images.add(img.toString());
          }
        }
      }
    }

    final rawItems =
        json['portfolioItems'] ?? json['portfolioProjects'] ?? json['projects'];
    if (rawItems is List) {
      for (final item in rawItems) {
        if (item is String && item.isNotEmpty) {
          images.add(item);
        } else if (item is Map) {
          final mediaList =
              item['mediaUrls'] ?? item['images'] ?? item['media'];
          if (mediaList is List && mediaList.isNotEmpty) {
            for (final m in mediaList) {
              if (m != null &&
                  m.toString().isNotEmpty &&
                  !images.contains(m.toString())) {
                images.add(m.toString());
              }
            }
          }
          final single =
              item['imageUrl'] ?? item['image'] ?? item['coverImage'];
          if (single != null &&
              single.toString().isNotEmpty &&
              !images.contains(single.toString())) {
            images.add(single.toString());
          }
        }
      }
    }

    return images;
  }

  static List<String> _parseListOrDelimitedString(dynamic value) {
    if (value is List) {
      return value
          .map((e) => e.toString().trim())
          .where((e) => e.isNotEmpty)
          .toList();
    } else if (value is String && value.isNotEmpty) {
      return value
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return const [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'companyName': companyName,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'isVerified': isVerified,
      'yearsOfExperience': yearsOfExperience,
      'projectsCompiled': projectsCompiled,
      'verificationStatus': verificationStatus,
      'commercialRegister': commercialRegister,
      'taxCard': taxCard,
      'aboutMe': aboutMe,
      'specializations': specializations,
      'coveredGovernorates': coveredGovernorates,
      'portfolioImages': portfolioImages,
      'profileImagePath': profileImagePath,
      'isCompleted': isCompleted,
    };
  }
}
