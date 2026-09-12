enum MessageSender { user, copilot }

class CopilotMessage {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;
  final List<String> sources; // Optional sources for copilot messages

  const CopilotMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.sources = const [],
  });

  CopilotMessage copyWith({
    String? id,
    String? text,
    MessageSender? sender,
    DateTime? timestamp,
    List<String>? sources,
  }) {
    return CopilotMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      sources: sources ?? this.sources,
    );
  }
}
