import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watad/core/services/file_download_service.dart';
import 'package:watad/features/dashboard/owner/contracts/data/models/contract_details_dto.dart';
import 'package:watad/features/dashboard/owner/contracts/domain/usecases/generate_contract_pdf_usecase.dart';
import 'package:watad/features/dashboard/owner/contracts/domain/usecases/get_contract_details_usecase.dart';


abstract class ContractDetailsState extends Equatable {
  const ContractDetailsState();

  @override
  List<Object?> get props => [];
}

class ContractDetailsInitial extends ContractDetailsState {}

class ContractDetailsLoading extends ContractDetailsState {}

class ContractDetailsSuccess extends ContractDetailsState {
  final ContractDetailsDto contractDetails;
  const ContractDetailsSuccess(this.contractDetails);

  @override
  List<Object?> get props => [contractDetails];
}

class ContractDetailsError extends ContractDetailsState {
  final String message;
  const ContractDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

class ContractPdfLoading extends ContractDetailsState {}

class ContractPdfSuccess extends ContractDetailsState {}

class ContractPdfError extends ContractDetailsState {
  final String message;
  const ContractPdfError(this.message);

  @override
  List<Object?> get props => [message];
}

class ContractDetailsCubit extends Cubit<ContractDetailsState> {
  final GetContractDetailsUseCase getContractDetailsUseCase;
  final GenerateContractPdfUseCase generateContractPdfUseCase;
  final FileDownloadService fileDownloadService;

  ContractDetailsCubit({
    required this.getContractDetailsUseCase,
    required this.generateContractPdfUseCase,
    required this.fileDownloadService,
  }) : super(ContractDetailsInitial());

  Future<void> fetchContractDetails(String id) async {
    emit(ContractDetailsLoading());

    final result = await getContractDetailsUseCase(id);

    result.fold(
      (details) {
        emit(ContractDetailsSuccess(details));
      },
      (error) {
        emit(ContractDetailsError(error.errMessage));
      },
    );
  }

  Future<void> generateAndDownloadPdf(String projectId, String contractId) async {
    emit(ContractPdfLoading());

    final result = await generateContractPdfUseCase(projectId, contractId);

    await result.fold(
      (pdfUrl) async {
        try {
          await fileDownloadService.downloadAndOpenFile(
            url: pdfUrl,
            fileName: 'Contract_$contractId.pdf',
          );
          emit(ContractPdfSuccess());
        } catch (e) {
          emit(ContractPdfError('Failed to download or open file.'));
        }
      },
      (error) async {
        emit(ContractPdfError(error.errMessage));
      },
    );
  }
}
