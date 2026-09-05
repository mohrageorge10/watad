import 'package:flutter/material.dart';
import 'package:watad/core/theme/app_colors.dart';
export 'package:watad/core/theme/app_typography.dart';

class AppTextStyles {
  // ============== App Elevated Button ===============
  static const btnWhite600 = TextStyle(
    color: AppColors.white100,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const btnGrey600 = TextStyle(
    color: AppColors.darkGrey,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  // =============== Welcome Screen ===============
  static const primary600 = TextStyle(
    color: AppColors.primary700,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
  static const primary700 = TextStyle(
    color: AppColors.primary700,
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );
  static const primary800 = TextStyle(
    color: AppColors.primary700,
    fontSize: 40,
    fontWeight: FontWeight.w800,
  );
  static const primaryGreen600 = TextStyle(
    color: AppColors.primaryGreen,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  // =============== Common Typography ===============
  static const font24Bold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.grey900,
  );

  static const font20SemiBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.grey900,
  );

  static const font16SemiBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.grey900,
  );

  static const font14Medium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.grey600,
  );

  static const font14Regular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey600,
  );

  static const font12Regular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.grey500,
  );
}

typedef AppTextStyle = AppTextStyles;
