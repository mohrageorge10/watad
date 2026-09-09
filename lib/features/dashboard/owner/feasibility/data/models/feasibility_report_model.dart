import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';

class FeasibilityReportModel extends FeasibilityReport {
  const FeasibilityReportModel({
    required super.id,
    required super.estimatedTotalCost,
    required super.materialsCost,
    required super.laborCost,
    required super.finishesCost,
    required super.contingenciesCost,
    required super.totalBuiltArea,
    required super.finishingLevel,
  });

  factory FeasibilityReportModel.fromJson(Map<String, dynamic> json) {
    return FeasibilityReportModel(
      id: json['id'] as String? ?? json['feasibilityReportId'] as String? ?? '',
      estimatedTotalCost: (json['totalEstimatedCost'] as num?)?.toDouble() ?? 0.0,
      materialsCost: (json['materialsCost'] as num?)?.toDouble() ?? 0.0,
      laborCost: (json['laborCost'] as num?)?.toDouble() ?? 0.0,
      finishesCost: (json['finishingCost'] as num?)?.toDouble() ?? 0.0,
      contingenciesCost: (json['contingencyBuffer'] as num?)?.toDouble() ?? 0.0,
      totalBuiltArea: (json['totalBuiltArea'] as num?)?.toDouble() ?? 0.0,
      finishingLevel: (json['finishingLevel'] as num?)?.toInt() ?? 0,
    );
  }
}
