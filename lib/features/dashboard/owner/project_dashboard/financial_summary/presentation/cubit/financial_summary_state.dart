import 'package:equatable/equatable.dart';
import '../../domain/entities/financial_summary_data.dart';

abstract class FinancialSummaryState extends Equatable {
  const FinancialSummaryState();

  @override
  List<Object?> get props => [];
}

class FinancialSummaryInitial extends FinancialSummaryState {}

class FinancialSummaryLoading extends FinancialSummaryState {}

class FinancialSummaryLoaded extends FinancialSummaryState {
  final FinancialSummaryData data;

  const FinancialSummaryLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class FinancialSummaryError extends FinancialSummaryState {
  final String message;

  const FinancialSummaryError(this.message);

  @override
  List<Object?> get props => [message];
}
