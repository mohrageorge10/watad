import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/profile/data/models/review_model.dart';
import 'package:watad/features/contractor/profile/domain/repositories/contractor_profile_repository.dart';

class GetContractorReviewsUseCase {
  final ContractorProfileRepository repository;

  const GetContractorReviewsUseCase(this.repository);

  Future<ApiResult<List<ReviewModel>>> call() async {
    return await repository.fetchMyReviews();
  }
}
