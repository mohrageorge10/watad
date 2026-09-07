import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';

class RoleSelectionFooterSection extends StatelessWidget {
  const RoleSelectionFooterSection({
    super.key,
    required this.onContinuePressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final VoidCallback onContinuePressed;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      title: 'Continue',
      isLoading: isLoading,
      isDisabled: !isEnabled,
      onPressed: onContinuePressed,
      backgroundColor: AppColors.primary,
      borderRadius: 12,
      height: 56,
      textStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white100,
      ),
    );
  }
}
