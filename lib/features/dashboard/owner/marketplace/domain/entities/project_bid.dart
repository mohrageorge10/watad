import 'package:equatable/equatable.dart';

class ProjectBid extends Equatable {
  final String id;
  final String contractorName;
  final String contractorImageUrl;
  final String date;
  final double amount;
  final int durationDays;
  final String status;

  const ProjectBid({
    required this.id,
    required this.contractorName,
    required this.contractorImageUrl,
    required this.date,
    required this.amount,
    required this.durationDays,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        contractorName,
        contractorImageUrl,
        date,
        amount,
        durationDays,
        status,
      ];
}
