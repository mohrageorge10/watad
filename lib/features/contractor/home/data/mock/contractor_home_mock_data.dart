import 'package:watad/features/contractor/home/data/models/contractor_bid_model.dart';
import 'package:watad/features/contractor/home/data/models/contractor_home_model.dart';
import 'package:watad/features/contractor/home/data/models/contractor_project_model.dart';

class ContractorHomeMockData {
  ContractorHomeMockData._();

  /// Flag to toggle empty state vs populated state for testing
  static bool forceEmptyState = false;

  /// Populated State matching the user JSON
  static ContractorHomeModel getPopulatedHomeData({String? userName}) {
    return ContractorHomeModel(
      userName: userName?.isNotEmpty == true ? userName! : 'Mr. Ali',
      headline: 'Your operational command center. Everything',
      completeProfileText:
          'Complete Your Company details and portfolio to increase your chances of getting accepted by 80%',
      ongoingProjectsCount: 3,
      activeProjects: const [
        ContractorProjectModel(
          id: 'proj_1',
          title: 'Mountain View Villa',
          location: 'New Cairo, Egypt',
          time: 'Updated 2 hours ago',
          image: 'mountain_view_villa.png',
          badgeText: 'In Progress',
          badgeColorHex: '#00B368',
          progress: '62%',
        ),
        ContractorProjectModel(
          id: 'proj_2',
          title: 'Seaside Villa',
          location: 'Ain Sokhna, Egypt',
          time: 'Updated 1 day ago',
          image: 'seaside_villa.png',
          badgeText: 'Design Phase',
          badgeColorHex: '#FFB020',
          progress: '25%',
        ),
        ContractorProjectModel(
          id: 'proj_3',
          title: 'Zayed Residence',
          location: '6th of October, Egypt',
          time: 'Updated 3 days ago',
          image: 'zayed_residence.png',
          badgeText: 'Draft',
          badgeColorHex: '#8E8E93',
          progress: '10%',
        ),
      ],
      recentBids: const [
        ContractorBidModel(
          id: 'bid_1',
          title: 'New Cairo Retail Shop',
          location: 'New Cairo, Egypt',
          amount: 'EGP 2,500,000',
          image: 'retail_shop.png',
          badgeText: 'Pending Review',
          badgeColorHex: '#009688',
        ),
      ],
    );
  }

  /// Empty State for new contractors with 0 projects and 0 bids
  static ContractorHomeModel getEmptyHomeData({String? userName}) {
    return ContractorHomeModel(
      userName: userName?.isNotEmpty == true ? userName! : 'Mr. Ali',
      headline: 'Your operational command center. Everything',
      completeProfileText:
          'Complete Your Company details and portfolio to increase your chances of getting accepted by 80%',
      ongoingProjectsCount: 0,
      activeProjects: const [],
      recentBids: const [],
    );
  }

  /// Partial state: Contractor has active projects but 0 bids
  static ContractorHomeModel getPartialHomeData({String? userName}) {
    final populated = getPopulatedHomeData(userName: userName);
    return ContractorHomeModel(
      userName: populated.userName,
      headline: populated.headline,
      completeProfileText: populated.completeProfileText,
      ongoingProjectsCount: populated.ongoingProjectsCount,
      activeProjects: populated.activeProjects,
      recentBids: const [], // 0 bids -> RecentBidsSection will show its empty card!
    );
  }

  /// Resolve mock data based on contractor ID or flag
  static ContractorHomeModel getHomeDataForContractor({
    required String contractorId,
    String? userName,
  }) {
    if (forceEmptyState) {
      return getEmptyHomeData(userName: userName);
    }
    // New contractors or empty account IDs return empty state
    if (contractorId.startsWith('new_') || contractorId == 'empty') {
      return getEmptyHomeData(userName: userName);
    }
    // Partial scenario
    if (contractorId.startsWith('partial_')) {
      return getPartialHomeData(userName: userName);
    }
    return getPopulatedHomeData(userName: userName);
  }
}
