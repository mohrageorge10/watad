import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';
import 'package:watad/features/copilot/presentation/widgets/assistant_chat_bubble.dart';
import 'package:watad/features/copilot/presentation/widgets/empty_copilot_state_widget.dart';
import 'package:watad/features/copilot/presentation/widgets/user_chat_bubble.dart';

class ChatMessagesSection extends StatelessWidget {
  final List<ChatMessageDto> messages;
  final bool isStreaming;
  final ScrollController scrollController;
  final VoidCallback onNewChat;

  const ChatMessagesSection({
    Key? key,
    required this.messages,
    required this.isStreaming,
    required this.scrollController,
    required this.onNewChat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty && !isStreaming) {
      return EmptyCopilotStateWidget(
        onNewChat: onNewChat,
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isLastMessage = index == messages.length - 1;
        
        if (message.isUser) {
          return UserChatBubble(message: message);
        } else {
          return AssistantChatBubble(
            message: message,
            isStreaming: isLastMessage && isStreaming,
          );
        }
      },
    );
  }
}
