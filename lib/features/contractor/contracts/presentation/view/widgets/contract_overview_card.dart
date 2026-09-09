import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class ContractOverviewCard extends StatelessWidget {
  final String contractValue;
  final String startDate;
  final String endDate;
  final String duration;

  const ContractOverviewCard({
    super.key,
    required this.contractValue,
    required this.startDate,
    required this.endDate,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          // 1. Contract Value
          _buildRow(
            label: 'Contract Value',
            value: contractValue,
            isValueBold: true,
          ),
          SizedBox(height: 16.h),

          // 2. Start Date
          _buildRow(
            label: 'Start Date',
            value: startDate,
            icon: Icons.calendar_today_outlined,
          ),
          SizedBox(height: 16.h),

          // 3. End Date
          _buildRow(
            label: 'End Date',
            value: endDate,
            icon: Icons.calendar_today_outlined,
          ),
          SizedBox(height: 16.h),

          // 4. Duration
          _buildRow(
            label: 'Duration',
            value: duration,
            icon: Icons.access_time_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String label,
    required String value,
    IconData? icon,
    bool isValueBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF1D1D1F),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: AppColors.primary,
                size: 15.r,
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              value,
              style: TextStyle(
                color: const Color(0xFF1D1D1F),
                fontSize: 14.sp,
                fontWeight: isValueBold ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
