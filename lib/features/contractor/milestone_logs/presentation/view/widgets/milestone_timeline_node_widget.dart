import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';

class MilestoneTimelineNodeWidget extends StatelessWidget {
  final MilestoneLogType type;
  final bool isFirst;
  final bool isLast;

  const MilestoneTimelineNodeWidget({
    super.key,
    required this.type,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color iconColor;
    IconData icon;

    switch (type) {
      case MilestoneLogType.dailyLog:
        borderColor = const Color(0xFF1E3A8A);
        iconColor = const Color(0xFF1E3A8A);
        icon = Icons.camera_alt_outlined;
        break;
      case MilestoneLogType.qaQc:
        borderColor = const Color(0xFF1E3A8A);
        iconColor = const Color(0xFF1E3A8A);
        icon = Icons.verified_user_outlined;
        break;
      case MilestoneLogType.safety:
        borderColor = const Color(0xFFFFA000);
        iconColor = const Color(0xFFFFA000);
        icon = Icons.warning_amber_rounded;
        break;
      case MilestoneLogType.system:
        borderColor = const Color(0xFF1E3A8A);
        iconColor = const Color(0xFF1E3A8A);
        icon = Icons.outlined_flag_rounded;
        break;
    }

    return Column(
      children: [
        // Top line
        Container(
          width: 1.5.w,
          height: 12.h,
          color: isFirst ? Colors.transparent : const Color(0xFFE5E5EA),
        ),

        // Circular Node Icon
        Container(
          width: 32.r,
          height: 32.r,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: 1.5.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: 16.r,
            ),
          ),
        ),

        // Bottom line
        Expanded(
          child: Container(
            width: 1.5.w,
            color: isLast ? Colors.transparent : const Color(0xFFE5E5EA),
          ),
        ),
      ],
    );
  }
}
