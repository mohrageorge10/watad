class ChatSessionSummaryDto {
  final String id;
  final String projectId;
  final String title;
  final DateTime createdAt;
  final int messagesCount;

  ChatSessionSummaryDto({
    required this.id,
    required this.projectId,
    required this.title,
    required this.createdAt,
    required this.messagesCount,
  });

  factory ChatSessionSummaryDto.fromJson(Map<String, dynamic> json) {
    return ChatSessionSummaryDto(
      id: json['id']?.toString() ?? json['Id']?.toString() ?? '',
      projectId: json['projectId']?.toString() ?? json['ProjectId']?.toString() ?? '',
      title: json['title']?.toString() ?? json['Title']?.toString() ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'].toString()) 
          : (json['CreatedAt'] != null ? DateTime.parse(json['CreatedAt'].toString()) : DateTime.now()),
      messagesCount: (json['messagesCount'] ?? json['MessagesCount'] ?? 0) as int,
    );
  }
}
