import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

import '../cubit/copilot_cubit.dart';
import '../cubit/copilot_state.dart';
import '../widgets/copilot_empty_state.dart';
import '../widgets/copilot_message_bubble.dart';
import '../widgets/copilot_message_composer.dart';
import 'conversation_history_view.dart';

class CopilotChatView extends StatelessWidget {
  const CopilotChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CopilotCubit(),
      child: const _CopilotChatBody(),
    );
  }
}

class _CopilotChatBody extends StatefulWidget {
  const _CopilotChatBody();

  @override
  State<_CopilotChatBody> createState() => _CopilotChatBodyState();
}

class _CopilotChatBodyState extends State<_CopilotChatBody> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _openHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ConversationHistoryView(
        onNewSession: () {
          context.read<CopilotCubit>().startNewChat();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white100,
            boxShadow: [
              BoxShadow(
                color: AppColors.black100.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 20.w),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Watad Copilot',
                          style: AppTextStyles.font16SemiBold.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 6.w,
                              height: 6.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green, // Live indicator
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Online',
                              style: AppTextStyles.font12RegularGrey.copyWith(
                                color: AppColors.grey500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.history, color: AppColors.primary, size: 24.w),
                    onPressed: _openHistory,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<CopilotCubit, CopilotState>(
        listener: (context, state) {
          if (state is CopilotActive) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom();
            });
          }
        },
        builder: (context, state) {
          final messages = state.messages;
          final isTyping = state is CopilotActive ? state.isTyping : false;
          final streamingText = state is CopilotActive ? state.streamingText : null;

          return Column(
            children: [
              if (messages.isEmpty && (state is CopilotInitial)) ...[
                Expanded(
                  child: CopilotEmptyState(
                    onActionTap: (action) {
                      context.read<CopilotCubit>().sendMessage("I'd like to $action");
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    itemCount: messages.length + (streamingText != null ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < messages.length) {
                        return CopilotMessageBubble(message: messages[index]);
                      } else {
                        // Streaming bubble
                        return _buildStreamingBubble(streamingText!);
                      }
                    },
                  ),
                ),
              ],
              CopilotMessageComposer(
                isSending: isTyping,
                onSend: (text) {
                  context.read<CopilotCubit>().sendMessage(text);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStreamingBubble(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            margin: EdgeInsets.only(right: 8.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.smart_toy_outlined,
              size: 18.w,
              color: AppColors.primary,
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.white100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(4.r),
                  bottomRight: Radius.circular(16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black100.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: text.isEmpty 
                  ? SizedBox(
                      width: 24.w,
                      height: 12.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.w,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : Text(
                      text,
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.black100,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
