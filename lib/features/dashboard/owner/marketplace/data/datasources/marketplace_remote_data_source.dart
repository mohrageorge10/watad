import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/features/dashboard/owner/marketplace/data/models/bid_details_model.dart';
import 'package:watad/features/dashboard/owner/marketplace/data/models/contractor_profile_model.dart';
import 'package:watad/features/dashboard/owner/marketplace/data/models/project_bid_model.dart';

abstract class MarketplaceRemoteDataSource {
  Future<List<ContractorProfileModel>> getRecommendedContractors(String projectId);
  Future<List<ProjectBidModel>> getProjectBids({
    required String projectId,
    String? sortBy,
    double? maxCost,
    int? maxDurationDays,
  });
  Future<BidDetailsModel> getBidDetails(String bidId);
  Future<void> acceptBid(String bidId);
  Future<void> rejectBid(String bidId);
}

class MarketplaceRemoteDataSourceImpl implements MarketplaceRemoteDataSource {
  final ApiConsumer apiConsumer;

  MarketplaceRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<ContractorProfileModel>> getRecommendedContractors(String projectId) async {
    final response = await apiConsumer.get(EndPoints.recommendedContractors(projectId));
    final dataList = response[ApiKey.data] as List;
    return dataList.map((e) => ContractorProfileModel.fromJson(e)).toList();
  }

  @override
  Future<List<ProjectBidModel>> getProjectBids({
    required String projectId,
    String? sortBy,
    double? maxCost,
    int? maxDurationDays,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (sortBy != null && sortBy.isNotEmpty) queryParameters['sortBy'] = sortBy;
    if (maxCost != null) queryParameters['maxCost'] = maxCost;
    if (maxDurationDays != null) queryParameters['maxDurationDays'] = maxDurationDays;

    final response = await apiConsumer.get(
      EndPoints.projectBids(projectId),
      queryParameters: queryParameters,
    );
    final dataList = response[ApiKey.data] as List;
    return dataList.map((e) => ProjectBidModel.fromJson(e)).toList();
  }

  @override
  Future<BidDetailsModel> getBidDetails(String bidId) async {
    final response = await apiConsumer.get(EndPoints.bidDetails(bidId));
    return BidDetailsModel.fromJson(response[ApiKey.data]);
  }

  @override
  Future<void> acceptBid(String bidId) async {
    await apiConsumer.post(EndPoints.acceptBid(bidId));
  }

  @override
  Future<void> rejectBid(String bidId) async {
    await apiConsumer.post(EndPoints.rejectBid(bidId));
  }
}
