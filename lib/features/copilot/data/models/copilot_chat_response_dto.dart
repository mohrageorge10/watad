class CopilotChatResponseDto {
  final String status;
  final String answer;
  final List<String> sources;

  CopilotChatResponseDto({
    required this.status,
    required this.answer,
    required this.sources,
  });

  factory CopilotChatResponseDto.fromJson(Map<String, dynamic> json) {
    return CopilotChatResponseDto(
      status: json['status']?.toString() ?? json['Status']?.toString() ?? '',
      answer: json['answer']?.toString() ?? json['Answer']?.toString() ?? '',
      sources: (json['sources'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? 
               (json['Sources'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
