import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';
import 'package:watad/features/contractor/milestone_logs/presentation/view/widgets/milestone_log_timeline_card_widget.dart';
import 'package:watad/features/contractor/milestone_logs/presentation/view/widgets/milestone_timeline_node_widget.dart';

class MilestoneLogsTimelineSection extends StatelessWidget {
  final List<MilestoneLogItemEntity> logs;

  const MilestoneLogsTimelineSection({
    super.key,
    required this.logs,
  });

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Center(
          child: Text(
            'No logs available for this category.',
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF8E8E93),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        final isFirst = index == 0;
        final isLast = index == logs.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Timeline Node & Line
              SizedBox(
                width: 38.w,
                child: MilestoneTimelineNodeWidget(
                  type: log.type,
                  isFirst: isFirst,
                  isLast: isLast,
                ),
              ),

              SizedBox(width: 8.w),

              // Right Content Card
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: MilestoneLogTimelineCardWidget(log: log),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
