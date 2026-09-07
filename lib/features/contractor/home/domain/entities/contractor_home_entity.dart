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

  const ContractorHomeEntity({
    required this.userName,
    required this.headline,
    required this.completeProfileText,
    required this.ongoingProjectsCount,
    required this.activeProjects,
    required this.recentBids,
  });

  bool get isEmptyState => activeProjects.isEmpty && recentBids.isEmpty;

  @override
  List<Object?> get props => [
        userName,
        headline,
        completeProfileText,
        ongoingProjectsCount,
        activeProjects,
        recentBids,
      ];
}
