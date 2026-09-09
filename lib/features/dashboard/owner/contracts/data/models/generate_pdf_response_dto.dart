class GeneratePdfResponseDto {
  final String contractId;
  final String pdfUrl;
  final String generatedAt;

  GeneratePdfResponseDto({
    required this.contractId,
    required this.pdfUrl,
    required this.generatedAt,
  });

  factory GeneratePdfResponseDto.fromJson(Map<String, dynamic> json) {
    return GeneratePdfResponseDto(
      contractId: json['contractId'] ?? '',
      pdfUrl: json['pdfUrl'] ?? '',
      generatedAt: json['generatedAt'] ?? '',
    );
  }
}
