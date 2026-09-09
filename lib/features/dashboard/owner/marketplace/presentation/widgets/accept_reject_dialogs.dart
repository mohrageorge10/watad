import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class AcceptRejectDialogs {
  static void showAcceptDialog(BuildContext context, VoidCallback onConfirm) {
    _showDialog(
      context: context,
      iconData: Icons.check_rounded,
      iconColor: AppColors.accept,
      title: 'Confirm Accept',
      message: 'Are you sure you want to accept\nthis bid?\n\nYou can change this decision\nlater from bids history.',
      confirmText: 'Confirm Accept',
      confirmColor: AppColors.accept,
      onConfirm: onConfirm,
    );
  }

  static void showRejectDialog(BuildContext context, VoidCallback onConfirm) {
    _showDialog(
      context: context,
      iconData: Icons.close_rounded,
      iconColor: AppColors.alert,
      title: 'Confirm Reject',
      message: 'Are you sure you want to reject\nthis bid?\n\nYou can change this decision\nlater from bids history.',
      confirmText: 'Confirm Reject',
      confirmColor: AppColors.alert,
      onConfirm: onConfirm,
    );
  }

  static void _showDialog({
    required BuildContext context,
    required IconData iconData,
    required Color iconColor,
    required String title,
    required String message,
    required String confirmText,
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (BuildContext ctx) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          backgroundColor: AppColors.white100,
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64.r,
                  height: 64.r,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5E7EB), // Light grey circle
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    iconData,
                    color: iconColor,
                    size: 32.r,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  title,
                  style: AppTextStyles.font20SemiBold.copyWith(
                    color: AppColors.primary700,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font14Medium.copyWith(
                    color: AppColors.smallText,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(ctx),
                        child: Container(
                          height: 44.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.white100,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.primary700),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Cancel',
                              style: AppTextStyles.font16SemiBold.copyWith(
                                color: AppColors.primary700,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 44.h,
                        child: AppElevatedButton(
                          title: confirmText,
                          backgroundColor: confirmColor,
                          textStyle: AppTextStyles.btnWhite600.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp, // slightly smaller to prevent text overflow
                          ),
                          onPressed: () {
                            Navigator.pop(ctx); 
                            onConfirm(); 
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
