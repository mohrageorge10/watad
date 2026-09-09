import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/marketplace/data/datasources/marketplace_remote_data_source.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/bid_details.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/contractor_profile.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/project_bid.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/repositories/marketplace_repository.dart';

class MarketplaceRepositoryImpl implements MarketplaceRepository {
  final MarketplaceRemoteDataSource remoteDataSource;

  const MarketplaceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<ContractorProfile>>> getRecommendedContractors(String projectId) async {
    try {
      final result = await remoteDataSource.getRecommendedContractors(projectId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<ProjectBid>>> getProjectBids({
    required String projectId,
    String? sortBy,
    double? maxCost,
    int? maxDurationDays,
  }) async {
    try {
      final result = await remoteDataSource.getProjectBids(
        projectId: projectId,
        sortBy: sortBy,
        maxCost: maxCost,
        maxDurationDays: maxDurationDays,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<BidDetails>> getBidDetails(String bidId) async {
    try {
      final result = await remoteDataSource.getBidDetails(bidId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> acceptBid(String bidId) async {
    try {
      await remoteDataSource.acceptBid(bidId);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> rejectBid(String bidId) async {
    try {
      await remoteDataSource.rejectBid(bidId);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
