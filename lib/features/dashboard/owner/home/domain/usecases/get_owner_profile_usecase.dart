import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/owner_profile.dart';
import 'package:watad/features/dashboard/owner/home/domain/repositories/home_repository.dart';

class GetOwnerProfileUseCase {
  final HomeRepository repository;

  GetOwnerProfileUseCase(this.repository);

  Future<ApiResult<OwnerProfile>> call() async {
    return await repository.getOwnerProfile();
  }
}
