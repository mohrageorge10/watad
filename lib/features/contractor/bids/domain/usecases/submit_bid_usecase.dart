import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/bids/domain/repositories/contractor_bids_repository.dart';

class SubmitBidUseCase {
  final ContractorBidsRepository repository;

  SubmitBidUseCase(this.repository);

  Future<ApiResult<bool>> call({
    required String projectId,
    required String proposedCost,
    required String proposedDuration,
    required String technicalProposal,
    String? attachmentFilePath,
  }) async {
    return await repository.submitBid(
      projectId: projectId,
      proposedCost: proposedCost,
      proposedDuration: proposedDuration,
      technicalProposal: technicalProposal,
      attachmentFilePath: attachmentFilePath,
    );
  }
}
