import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'copilot_quick_action_card.dart';
import 'copilot_project_specs_card.dart';

class CopilotEmptyState extends StatelessWidget {
  final Function(String) onActionTap;

  const CopilotEmptyState({
    super.key,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          // Illustration or Robot Icon
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.smart_toy_outlined,
              size: 40.w,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'How can I assist you with your project today?',
            style: AppTextStyles.font18SemiBoldDark.copyWith(
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            'Ask about contracts, specifications, budget, or site progress.',
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.grey500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 48.h),
          Row(
            children: [
              Expanded(
                child: CopilotQuickActionCard(
                  title: 'Review Contract',
                  subtitle: 'Find key clauses & terms',
                  onTap: () => onActionTap('Review Contract'),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CopilotQuickActionCard(
                  title: 'Check Budget',
                  subtitle: 'Costs, payments & values',
                  onTap: () => onActionTap('Check Budget'),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CopilotProjectSpecsCard(
            onTap: () => onActionTap('Project Specs'),
          ),
        ],
      ),
    );
  }
}
