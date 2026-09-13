import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';

class MilestoneLogsFilterChipsSection extends StatelessWidget {
  final MilestoneLogType? selectedFilter;
  final int dailyLogsCount;
  final int qaqcCount;
  final int safetyCount;
  final ValueChanged<MilestoneLogType?> onFilterSelected;

  const MilestoneLogsFilterChipsSection({
    super.key,
    required this.selectedFilter,
    required this.dailyLogsCount,
    required this.qaqcCount,
    required this.safetyCount,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          // 1. Daily Logs
          _buildChip(
            label: 'Daily Logs ($dailyLogsCount)',
            isSelected: selectedFilter == MilestoneLogType.dailyLog,
            onTap: () => onFilterSelected(MilestoneLogType.dailyLog),
          ),

          SizedBox(width: 8.w),

          // 2. QA/QC
          _buildChip(
            label: 'QA/QC ($qaqcCount)',
            isSelected: selectedFilter == MilestoneLogType.qaQc,
            onTap: () => onFilterSelected(MilestoneLogType.qaQc),
          ),

          SizedBox(width: 8.w),

          // 3. Safety
          _buildChip(
            label: 'Safety ($safetyCount)',
            isSelected: selectedFilter == MilestoneLogType.safety,
            onTap: () => onFilterSelected(MilestoneLogType.safety),
          ),

          SizedBox(width: 8.w),

          // 4. Filter Action Icon Button (Opens Filter Bottom Sheet)
          GestureDetector(
            onTap: () => _showFilterBottomSheet(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: selectedFilter != null
                    ? const Color(0xFF1E3A8A).withValues(alpha: 0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: selectedFilter != null
                      ? const Color(0xFF1E3A8A)
                      : const Color(0xFFE5E5EA),
                  width: selectedFilter != null ? 1.5.w : 1.w,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tune_rounded,
                    size: 14.r,
                    color: const Color(0xFF1E3A8A),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    selectedFilter != null ? 'Filtered' : 'Filter',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E3A8A),
                    ),
                  ),
                  if (selectedFilter != null) ...[
                    SizedBox(width: 4.w),
                    Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E3A8A),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        MilestoneLogType? tempSelected = selectedFilter;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filter Milestone Logs',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1D1D1F),
                          ),
                        ),
                        if (tempSelected != null)
                          TextButton(
                            onPressed: () {
                              setModalState(() {
                                tempSelected = null;
                              });
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFDC2626),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Filter Options
                    _buildModalOption(
                      title: 'All Logs',
                      icon: Icons.list_alt_rounded,
                      iconColor: const Color(0xFF1E3A8A),
                      isSelected: tempSelected == null,
                      onTap: () => setModalState(() => tempSelected = null),
                    ),
                    _buildModalOption(
                      title: 'Daily Logs ($dailyLogsCount)',
                      icon: Icons.camera_alt_outlined,
                      iconColor: const Color(0xFF1E3A8A),
                      isSelected: tempSelected == MilestoneLogType.dailyLog,
                      onTap: () => setModalState(
                          () => tempSelected = MilestoneLogType.dailyLog),
                    ),
                    _buildModalOption(
                      title: 'QA/QC Inspections ($qaqcCount)',
                      icon: Icons.verified_user_outlined,
                      iconColor: const Color(0xFF00A859),
                      isSelected: tempSelected == MilestoneLogType.qaQc,
                      onTap: () => setModalState(
                          () => tempSelected = MilestoneLogType.qaQc),
                    ),
                    _buildModalOption(
                      title: 'Safety Alerts ($safetyCount)',
                      icon: Icons.warning_amber_rounded,
                      iconColor: const Color(0xFFFFA000),
                      isSelected: tempSelected == MilestoneLogType.safety,
                      onTap: () => setModalState(
                          () => tempSelected = MilestoneLogType.safety),
                    ),
                    _buildModalOption(
                      title: 'System Events',
                      icon: Icons.flag_outlined,
                      iconColor: const Color(0xFF636366),
                      isSelected: tempSelected == MilestoneLogType.system,
                      onTap: () => setModalState(
                          () => tempSelected = MilestoneLogType.system),
                    ),

                    SizedBox(height: 16.h),

                    // Apply Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          onFilterSelected(tempSelected);
                        },
                        child: Text(
                          'Apply Filter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildModalOption({
    required String title,
    required IconData icon,
    required Color iconColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0),
      leading: Container(
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: iconColor, size: 18.r),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF1D1D1F),
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle_rounded,
              color: const Color(0xFF1E3A8A), size: 20.r)
          : null,
      onTap: onTap,
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFFE5E5EA),
            width: 1.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF636366),
          ),
        ),
      ),
    );
  }
}
