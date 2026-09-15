class ChatMessageDto {
  final String id;
  final String sender;
  final String content;
  final String? sourcesJson;
  final DateTime createdOn;

  bool get isUser => sender.toLowerCase() == 'user';

  ChatMessageDto({
    required this.id,
    required this.sender,
    required this.content,
    this.sourcesJson,
    required this.createdOn,
  });

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) {
    return ChatMessageDto(
      id: json['id']?.toString() ?? json['Id']?.toString() ?? '',
      sender: json['sender']?.toString() ?? json['Sender']?.toString() ?? '',
      content: json['content']?.toString() ?? json['Content']?.toString() ?? '',
      sourcesJson: json['sourcesJson']?.toString() ?? json['SourcesJson']?.toString(),
      createdOn: json['createdOn'] != null 
          ? DateTime.parse(json['createdOn'].toString()) 
          : (json['CreatedOn'] != null ? DateTime.parse(json['CreatedOn'].toString()) : DateTime.now()),
    );
  }
}
