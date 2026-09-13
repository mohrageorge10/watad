import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_bid_entity.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_project_entity.dart';

class ContractorHomeEntity extends Equatable {
  final String userName;
  final String headline;
  final String completeProfileText;
  final int ongoingProjectsCount;
  final List<ContractorProjectEntity> activeProjects;
  final List<ContractorBidEntity> recentBids;
  final bool isProfileComplete;
  final String? userImage;

  const ContractorHomeEntity({
    required this.userName,
    required this.headline,
    required this.completeProfileText,
    required this.ongoingProjectsCount,
    required this.activeProjects,
    required this.recentBids,
    this.isProfileComplete = false,
    this.userImage,
  });

  bool get isEmptyState => activeProjects.isEmpty && recentBids.isEmpty;

  ContractorHomeEntity copyWith({
    String? userName,
    String? headline,
    String? completeProfileText,
    int? ongoingProjectsCount,
    List<ContractorProjectEntity>? activeProjects,
    List<ContractorBidEntity>? recentBids,
    bool? isProfileComplete,
    String? userImage,
    bool clearUserImage = false,
  }) {
    return ContractorHomeEntity(
      userName: userName ?? this.userName,
      headline: headline ?? this.headline,
      completeProfileText: completeProfileText ?? this.completeProfileText,
      ongoingProjectsCount: ongoingProjectsCount ?? this.ongoingProjectsCount,
      activeProjects: activeProjects ?? this.activeProjects,
      recentBids: recentBids ?? this.recentBids,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      userImage: clearUserImage ? null : (userImage ?? this.userImage),
    );
  }

  @override
  List<Object?> get props => [
        userName,
        headline,
        completeProfileText,
        ongoingProjectsCount,
        activeProjects,
        recentBids,
        isProfileComplete,
        userImage,
      ];
}
