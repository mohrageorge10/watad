import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/bid_details.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/contractor_profile.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/project_bid.dart';

abstract class MarketplaceRepository {
  Future<ApiResult<List<ContractorProfile>>> getRecommendedContractors(String projectId);
  Future<ApiResult<List<ProjectBid>>> getProjectBids({
    required String projectId,
    String? sortBy,
    double? maxCost,
    int? maxDurationDays,
  });
  Future<ApiResult<BidDetails>> getBidDetails(String bidId);
  Future<ApiResult<void>> acceptBid(String bidId);
  Future<ApiResult<void>> rejectBid(String bidId);
}
