class FeasibilityReport {
  final String id;
  final double estimatedTotalCost;
  final double materialsCost;
  final double laborCost;
  final double finishesCost;
  final double contingenciesCost;
  final double totalBuiltArea;
  final int finishingLevel;

  const FeasibilityReport({
    required this.id,
    required this.estimatedTotalCost,
    required this.materialsCost,
    required this.laborCost,
    required this.finishesCost,
    required this.contingenciesCost,
    required this.totalBuiltArea,
    required this.finishingLevel,
  });
}
