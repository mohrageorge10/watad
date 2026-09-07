import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/home/data/datasources/contractor_home_remote_data_source.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_home_entity.dart';
import 'package:watad/features/contractor/home/domain/repositories/contractor_home_repository.dart';

class ContractorHomeRepositoryImpl implements ContractorHomeRepository {
  final ContractorHomeRemoteDataSource remoteDataSource;
  final CacheHelper cacheHelper;

  ContractorHomeRepositoryImpl({
    required this.remoteDataSource,
    required this.cacheHelper,
  });

  @override
  Future<ApiResult<ContractorHomeEntity>> getContractorHomeData({
    required String contractorId,
  }) async {
    try {
      final cachedUserName = cacheHelper.getData(key: CacheKeys.userName) as String?;
      final result = await remoteDataSource.getContractorHomeData(
        contractorId: contractorId,
        userName: cachedUserName,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
