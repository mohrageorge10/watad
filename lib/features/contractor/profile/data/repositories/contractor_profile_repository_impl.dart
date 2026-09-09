import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/profile/data/datasources/contractor_profile_remote_data_source.dart';
import 'package:watad/features/contractor/profile/data/models/review_model.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/domain/repositories/contractor_profile_repository.dart';

class ContractorProfileRepositoryImpl implements ContractorProfileRepository {
  final ContractorProfileRemoteDataSource remoteDataSource;
  final CacheHelper cacheHelper;

  ContractorProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.cacheHelper,
  });

  @override
  Future<ApiResult<ContractorProfileEntity>> getContractorProfile({
    required String contractorId,
  }) async {
    try {
      final cachedUserName =
          cacheHelper.getData(key: CacheKeys.userName) as String?;

      final result = await remoteDataSource.getContractorProfile(
        contractorId: contractorId,
        userName: cachedUserName,
      );

      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<ContractorProfileEntity>> fetchContractorProfile() async {
    try {
      final result = await remoteDataSource.fetchContractorProfile();
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> updateContractorProfile({
    required Map<String, dynamic> profileData,
  }) async {
    try {
      await remoteDataSource.updateContractorProfile(profileData: profileData);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<ReviewModel>>> fetchMyReviews() async {
    try {
      final reviews = await remoteDataSource.fetchMyReviews();
      return ApiResult.success(reviews);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
