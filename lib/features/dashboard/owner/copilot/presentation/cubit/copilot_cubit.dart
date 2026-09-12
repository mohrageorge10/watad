import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/copilot_message.dart';
import 'copilot_state.dart';

class CopilotCubit extends Cubit<CopilotState> {
  CopilotCubit() : super(const CopilotInitial());

  void startNewChat() {
    emit(const CopilotInitial());
  }

  void sendMessage(String text) async {
    final userMessage = CopilotMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    final updatedMessages = List<CopilotMessage>.from(state.messages)..add(userMessage);

    // Transition to loading/typing state
    emit(CopilotActive(
      messages: updatedMessages,
      isTyping: true,
    ));

    // Simulate network delay before AI starts responding
    await Future.delayed(const Duration(seconds: 1));

    // Simulate AI streaming response
    const aiResponseText = "The roof concrete specification for Villa Al-Nargis is as follows:\n\n"
        "Concrete Class: C30/37\n"
        "Cement Type: Ordinary Portland Cement (OPC)\n"
        "Max Aggregate Size: 20 mm\n"
        "Slump: 100 - 150 mm\n"
        "Water-Cement Ratio: 0.45 - 0.55\n"
        "Admixtures: Superplasticizer (as per spec)\n"
        "Curing: Minimum 7 days";

    String currentStream = "";
    emit(CopilotActive(
      messages: updatedMessages,
      isTyping: true,
      streamingText: currentStream,
    ));

    final words = aiResponseText.split(' ');
    for (int i = 0; i < words.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      currentStream += (i == 0 ? "" : " ") + words[i];
      emit(CopilotActive(
        messages: updatedMessages,
        isTyping: true,
        streamingText: currentStream,
      ));
    }

    // Finalize AI message
    final aiMessage = CopilotMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: aiResponseText,
      sender: MessageSender.copilot,
      timestamp: DateTime.now(),
      sources: const ["Contract_v2.pdf", "BoQ_Excavation.xlsx"],
    );

    emit(CopilotActive(
      messages: List.from(updatedMessages)..add(aiMessage),
      isTyping: false,
    ));
  }
}
