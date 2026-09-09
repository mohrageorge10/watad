import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class ContractPartyTileWidget extends StatelessWidget {
  final String role;
  final String name;
  final bool isSigned;
  final String statusText;
  final bool isUnsignedRejected;

  const ContractPartyTileWidget({
    super.key,
    required this.role,
    required this.name,
    required this.isSigned,
    required this.statusText,
    this.isUnsignedRejected = false,
  });

  @override
  Widget build(BuildContext context) {
    // In preview screen, the avatar outline matches the primary color
    final bool hasPrimaryBorder = isSigned || isUnsignedRejected;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Leading Circular Avatar
        Container(
          width: 38.r,
          height: 38.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: hasPrimaryBorder
                ? AppColors.primary.withValues(alpha: 0.06)
                : const Color(0xFFF3F4F6),
            border: Border.all(
              color: hasPrimaryBorder
                  ? AppColors.primary
                  : const Color(0xFFD1D5DB),
              width: 1.5,
            ),
          ),
          child: Icon(
            Icons.person_outline_rounded,
            color: hasPrimaryBorder ? AppColors.primary : const Color(0xFF9CA3AF),
            size: 20.r,
          ),
        ),

        SizedBox(width: 12.w),

        // Middle: Role and Name
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                role,
                style: TextStyle(
                  color: const Color(0xFF8E8E93),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                name,
                style: TextStyle(
                  color: isSigned
                      ? AppColors.primary
                      : isUnsignedRejected
                          ? AppColors.primary
                          : const Color(0xFF1D1D1F),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 8.w),

        // Trailing Status
        Flexible(
          flex: 5,
          child: isSigned
              ? _buildSignedStatus()
              : isUnsignedRejected
                  ? _buildUnsignedRejectedStatus()
                  : _buildUnsignedBadge(),
        ),
      ],
    );
  }

  Widget _buildSignedStatus() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check_rounded,
          color: AppColors.accept,
          size: 16.r,
        ),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            statusText,
            style: TextStyle(
              color: AppColors.accept,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnsignedRejectedStatus() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.cancel_outlined,
          color: const Color(0xFF8E8E93),
          size: 16.r,
        ),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            statusText.isNotEmpty ? statusText : 'Not signed',
            style: TextStyle(
              color: const Color(0xFF8E8E93),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnsignedBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        statusText.isNotEmpty ? statusText : 'Not signed',
        style: TextStyle(
          color: const Color(0xFF6B7280),
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
