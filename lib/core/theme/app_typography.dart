import 'package:flutter/material.dart';
import 'package:watad/core/theme/app_colors.dart';

class AppTypography {
  AppTypography._();

  // ===========================================================================
  // 1. TEXT FONT (Headlines, Subtitles, Body, Captions, Label)
  // ===========================================================================

  // ---------------- Headlines ----------------
  /// H1. Headline | Semi Bold | Size 48 | Line 58
  static const TextStyle h1Headline = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w600,
    height: 58 / 48,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  /// H2. Headline | Semi Bold | Size 40 | Line 48
  static const TextStyle h2Headline = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: 48 / 40,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  /// H3. Headline | Semi Bold | Size 32 | Line 38
  static const TextStyle h3Headline = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 38 / 32,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  /// H4. Headline | Semi Bold | Size 28 | Line 34
  static const TextStyle h4Headline = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 34 / 28,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  /// H5. Headline | Semi Bold | Size 24 | Line 28
  static const TextStyle h5Headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 28 / 24,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  // ---------------- Subtitles ----------------
  /// S1. Subtitle | Semi Bold | Size 18 | Line 28
  static const TextStyle s1Subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 28 / 18,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  /// S2. Subtitle | Semi Bold | Size 16 | Line 24
  static const TextStyle s2Subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  // ---------------- Body ----------------
  /// B1. Body | Regular | Size 16 | Line 24
  static const TextStyle b1Body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  /// B2. Body | Medium | Size 16 | Line 24
  static const TextStyle b2Body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  /// B3. Body | Regular | Size 14 | Line 20
  static const TextStyle b3Body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  /// B4. Body | Medium | Size 14 | Line 20
  static const TextStyle b4Body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  // ---------------- Captions ----------------
  /// C1. Caption | Regular | Size 12 | Line 16
  static const TextStyle c1Caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  /// C2. Caption | Medium | Size 12 | Line 16
  static const TextStyle c2Caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  /// C3. Caption | Medium | Size 10 | Line 14
  static const TextStyle c3Caption = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 14 / 10,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  // ---------------- Label ----------------
  /// LABEL | Medium | Size 12 | Line 16
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0,
    color: AppColors.smallText,
  );

  // ===========================================================================
  // 2. BUTTON FONT (Giant, Large, Medium, Small, Tiny)
  // ===========================================================================

  /// Giant Button | Semi Bold | Size 18 | Line 24
  static const TextStyle buttonGiant = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
    letterSpacing: 0,
    color: AppColors.white100,
  );

  /// Large Button | Semi Bold | Size 16 | Line 20
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 20 / 16,
    letterSpacing: 0,
    color: AppColors.white100,
  );

  /// Medium Button | Semi Bold | Size 14 | Line 16
  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 16 / 14,
    letterSpacing: 0,
    color: AppColors.white100,
  );

  /// Small Button | Semi Bold | Size 12 | Line 16
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
    letterSpacing: 0,
    color: AppColors.white100,
  );

  /// Tiny Button | Semi Bold | Size 10 | Line 12
  static const TextStyle buttonTiny = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 12 / 10,
    letterSpacing: 0,
    color: AppColors.white100,
  );
}
