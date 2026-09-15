import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/copilot/presentation/cubit/copilot_cubit.dart';
import 'package:watad/features/copilot/presentation/cubit/copilot_state.dart';
import 'package:watad/features/copilot/presentation/sections/chat_input_section.dart';
import 'package:watad/features/copilot/presentation/sections/chat_messages_section.dart';
import 'package:watad/features/copilot/presentation/sections/copilot_history_drawer.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';

class CopilotView extends StatefulWidget {
  final String projectId;
  
  const CopilotView({Key? key, required this.projectId}) : super(key: key);

  @override
  State<CopilotView> createState() => _CopilotViewState();
}

class _CopilotViewState extends State<CopilotView> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white100,
            boxShadow: [
              BoxShadow(
                color: AppColors.black100.withOpacity(0.05),
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
                textDirection: TextDirection.rtl,
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
                          textDirection: TextDirection.rtl,
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
                              'Live',
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
                    icon: Icon(Icons.menu, color: AppColors.primary, size: 24.w),
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      endDrawer: CopilotHistoryDrawer(
        onNewSession: () {
          context.read<CopilotCubit>().startNewSession();
          Navigator.pop(context); // Close drawer
        },
      ),
      body: BlocConsumer<CopilotCubit, CopilotState>(
        listener: (context, state) {
          if (state is CopilotMessagesLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
          }
        },
        buildWhen: (previous, current) => 
            current is CopilotMessagesLoaded || current is CopilotMessagesLoading,
        builder: (context, state) {
          final isStreaming = state is CopilotMessagesLoaded && state.isStreaming;
          final List<ChatMessageDto> messages = state is CopilotMessagesLoaded ? state.messages : <ChatMessageDto>[];
          final isLoading = state is CopilotMessagesLoading;

          return Column(
            children: [
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ChatMessagesSection(
                        messages: messages,
                        isStreaming: isStreaming,
                        scrollController: _scrollController,
                        onNewChat: () {
                          context.read<CopilotCubit>().startNewSession();
                        },
                      ),
              ),
              ChatInputSection(
                isStreaming: isStreaming,
                onSend: (text) {
                  context.read<CopilotCubit>().askQuestion(text);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
