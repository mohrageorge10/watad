import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/contractor/contracts/domain/entities/contract_entity.dart';
import 'package:watad/features/contractor/contracts/domain/usecases/get_accepted_bid_contract_usecase.dart';
import 'package:watad/features/contractor/contracts/domain/usecases/get_contract_details_usecase.dart';
import 'package:watad/features/contractor/contracts/domain/usecases/sign_contract_usecase.dart';
import 'package:watad/features/contractor/contracts/presentation/cubit/contract_state.dart';

class ContractCubit extends Cubit<ContractState> {
  final GetContractDetailsUseCase getContractDetailsUseCase;
  final SignContractUseCase signContractUseCase;
  final GetAcceptedBidContractUseCase? getAcceptedBidContractUseCase;

  ContractCubit({
    required this.getContractDetailsUseCase,
    required this.signContractUseCase,
    this.getAcceptedBidContractUseCase,
  }) : super(const ContractInitial());

  ContractEntity? _currentContract;

  Future<void> loadContract(String contractId) async {
    emit(const ContractLoading());
    final result = await getContractDetailsUseCase(contractId);

    result.fold(
      (contract) {
        _currentContract = contract;
        emit(ContractLoaded(contract));
      },
      (failure) => emit(ContractError(failure.errMessage)),
    );
  }

  Future<void> loadContractByBid(String bidId) async {
    emit(const ContractLoading());
    if (getAcceptedBidContractUseCase != null) {
      final result = await getAcceptedBidContractUseCase!(bidId);
      result.fold(
        (contract) {
          if (contract != null) {
            _currentContract = contract;
            emit(ContractLoaded(contract));
          } else {
            emit(const ContractError('No contract found for this bid.'));
          }
        },
        (failure) => emit(ContractError(failure.errMessage)),
      );
    } else {
      await loadContract(bidId);
    }
  }

  Future<void> signCurrentContract({
    String? contractId,
    String? digitalSignature,
  }) async {
    final current = _currentContract ??
        ContractEntity(
          id: contractId ?? 'contract-mock',
          projectId: 'proj-101',
          projectName: 'Villa Construction Project - New Cairo',
          contractorId: 'c-101',
          contractorName: 'Al-Rayan Construction',
          clientId: 'u-501',
          clientName: 'Ahmed Al-Masry',
          status: 'Ready to Sign',
          totalAmount: 2450000.0,
          durationDays: 180,
          scopeOfWork: 'Villa Construction',
          termsAndConditions: 'Standard terms',
          createdAt: DateTime.now(),
        );

    emit(ContractSigning(current));

    final targetId =
        current.id.isNotEmpty ? current.id : (contractId ?? 'contract-mock');
    final result = await signContractUseCase(
      targetId,
      digitalSignature: digitalSignature,
    );

    result.fold(
      (success) {
        final updated = ContractEntity(
          id: current.id,
          projectId: current.projectId,
          projectName: current.projectName,
          contractorId: current.contractorId,
          contractorName: current.contractorName,
          clientId: current.clientId,
          clientName: current.clientName,
          status: 'Contractor Signed',
          totalAmount: current.totalAmount,
          durationDays: current.durationDays,
          scopeOfWork: current.scopeOfWork,
          termsAndConditions: current.termsAndConditions,
          contractorSignature: digitalSignature ?? 'digital_signature',
          contractorSignedAt: DateTime.now(),
          clientSignature: current.clientSignature,
          clientSignedAt: current.clientSignedAt,
          createdAt: current.createdAt,
        );

        _currentContract = updated;
        emit(ContractSignedSuccess(contract: updated));
      },
      (failure) => emit(ContractError(failure.errMessage)),
    );
  }
}
