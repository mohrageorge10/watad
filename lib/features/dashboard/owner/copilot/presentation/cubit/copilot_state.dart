import 'package:equatable/equatable.dart';
import '../../domain/entities/copilot_message.dart';

abstract class CopilotState extends Equatable {
  final List<CopilotMessage> messages;
  const CopilotState(this.messages);

  @override
  List<Object?> get props => [messages];
}

class CopilotInitial extends CopilotState {
  const CopilotInitial() : super(const []);
}

class CopilotActive extends CopilotState {
  final bool isTyping; // indicates if the AI is generating/loading
  final String? streamingText; // holds the partially generated text
  
  const CopilotActive({
    required List<CopilotMessage> messages,
    this.isTyping = false,
    this.streamingText,
  }) : super(messages);

  @override
  List<Object?> get props => [messages, isTyping, streamingText];
}

class CopilotError extends CopilotState {
  final String errorMessage;
  const CopilotError(List<CopilotMessage> messages, this.errorMessage) : super(messages);

  @override
  List<Object?> get props => [messages, errorMessage];
}
