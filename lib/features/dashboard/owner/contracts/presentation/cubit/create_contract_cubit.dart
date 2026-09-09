import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/create_contract_usecase.dart';
import '../../data/models/create_contract_request_dto.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/get_bid_details_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/bid_details.dart';

abstract class CreateContractState extends Equatable {
  const CreateContractState();

  @override
  List<Object?> get props => [];
}

class CreateContractInitial extends CreateContractState {}

class CreateContractLoading extends CreateContractState {}

class CreateContractFormReady extends CreateContractState {
  final int timestamp;
  CreateContractFormReady([int? ts]) : timestamp = ts ?? DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [timestamp];
}

class CreateContractSuccess extends CreateContractState {
  final String contractId;
  const CreateContractSuccess(this.contractId);

  @override
  List<Object?> get props => [contractId];
}

class CreateContractError extends CreateContractState {
  final String message;
  const CreateContractError(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateContractCubit extends Cubit<CreateContractState> {
  final CreateContractUseCase createContractUseCase;
  final GetBidDetailsUseCase getBidDetailsUseCase;
  
  // State variables for the form
  String bidId = '';
  String projectId = '';
  String contractorId = '';
  num totalValue = 0;
  String startDate = '';
  String endDate = '';
  String termsAndConditions = '';
  List<CreateMilestoneItemDto> milestones = [];
  BidDetails? bidDetails;
  bool isFetchingBidDetails = false;

  CreateContractCubit({
    required this.createContractUseCase,
    required this.getBidDetailsUseCase,
  }) : super(CreateContractInitial());

  Future<void> loadBidDetails() async {
    if (bidId.isEmpty) return;
    
    isFetchingBidDetails = true;
    emit(CreateContractLoading());

    final result = await getBidDetailsUseCase(bidId);
    result.fold(
      (data) {
        bidDetails = data;
        projectId = data.projectId;
        contractorId = data.contractorId;
        totalValue = data.amount;
        isFetchingBidDetails = false;
        emit(CreateContractFormReady());
      },
      (failure) {
        isFetchingBidDetails = false;
        emit(CreateContractError(failure.errMessage));
        emit(CreateContractFormReady());
      },
    );
  }

  void addMilestone(CreateMilestoneItemDto milestone) {
    milestones.add(milestone);
    emit(CreateContractFormReady()); // Re-emit to update UI
  }

  void removeMilestone(int index) {
    milestones.removeAt(index);
    emit(CreateContractFormReady());
  }

  String _formatApiDate(String dateStr) {
    if (dateStr.isEmpty) return dateStr;
    try {
      final parts = dateStr.split(' ');
      if (parts.length != 3) return dateStr;
      final day = parts[0].padLeft(2, '0');
      final monthStr = parts[1];
      final year = parts[2];
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      final monthIndex = months.indexOf(monthStr) + 1;
      final month = monthIndex.toString().padLeft(2, '0');
      return "$year-$month-$day";
    } catch (e) {
      return dateStr;
    }
  }

  void refreshUI() {
    emit(CreateContractFormReady());
  }

  Future<void> submitContract() async {
    if (bidDetails == null) return;
    if (totalValue <= 0 || startDate.isEmpty || endDate.isEmpty) {
      emit(const CreateContractError('Please fill all required fields'));
      emit(CreateContractFormReady());
      return;
    }
    
    if (milestones.isEmpty) {
      emit(const CreateContractError('Please add at least one payment milestone.'));
      emit(CreateContractFormReady());
      return;
    }
    
    // Check if cost percentage sums to 100
    num totalPercentage = milestones.fold(0, (sum, item) => sum + item.costPercentage);
    if (totalPercentage != 100) {
      emit(const CreateContractError('Percentages across all milestones must sum to 100%.'));
      emit(CreateContractFormReady());
      return;
    }

    emit(CreateContractLoading());

    final request = CreateContractRequestDto(
      projectId: bidDetails!.projectId,
      contractorId: bidDetails!.contractorId,
      totalValue: totalValue,
      startDate: _formatApiDate(startDate),
      endDate: _formatApiDate(endDate),
      termsAndConditions: termsAndConditions.isNotEmpty ? termsAndConditions : null,
      milestones: milestones,
    );

    final result = await createContractUseCase(request);

    result.fold(
      (contractId) {
        emit(CreateContractSuccess(contractId));
      },
      (error) {
        emit(CreateContractError(error.errMessage));
        emit(CreateContractFormReady());
      },
    );
  }
}
