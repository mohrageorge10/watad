import 'package:watad/features/contractor/home/data/models/contractor_bid_model.dart';
import 'package:watad/features/contractor/home/data/models/contractor_project_model.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_home_entity.dart';

class ContractorHomeModel extends ContractorHomeEntity {
  const ContractorHomeModel({
    required super.userName,
    required super.headline,
    required super.completeProfileText,
    required super.ongoingProjectsCount,
    required super.activeProjects,
    required super.recentBids,
    super.isProfileComplete = false,
  });

  factory ContractorHomeModel.fromJson(Map<String, dynamic> json) {
    final activeProjectsList = (json['active_projects'] as List<dynamic>?)
            ?.map((e) =>
                ContractorProjectModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final recentBidsList = (json['recent_bids'] as List<dynamic>?)
            ?.map(
                (e) => ContractorBidModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    return ContractorHomeModel(
      userName: json['user_name'] as String? ?? 'Mr. Ali',
      headline: json['headline'] as String? ??
          'Your operational command center. Everything',
      completeProfileText: json['complete_profile_text'] as String? ??
          'Complete Your Company details and portfolio to increase your chances of getting accepted by 80%',
      ongoingProjectsCount: json['ongoing_projects_count'] as int? ??
          activeProjectsList.length,
      activeProjects: activeProjectsList,
      recentBids: recentBidsList,
      isProfileComplete: json['is_profile_complete'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
      'headline': headline,
      'complete_profile_text': completeProfileText,
      'ongoing_projects_count': ongoingProjectsCount,
      'active_projects': activeProjects
          .map((e) => (e as ContractorProjectModel).toJson())
          .toList(),
      'recent_bids':
          recentBids.map((e) => (e as ContractorBidModel).toJson()).toList(),
      'is_profile_complete': isProfileComplete,
    };
  }
}
