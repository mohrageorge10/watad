import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ================= Project Brand Palette =================
  /// Primary Blue - 2947A9
  static const Color primary = Color(0xFF2947A9);

  /// Accept / Success Green - 00A859
  static const Color accept = Color(0xFF00A859);

  /// Alert / Danger Red - DC2626
  static const Color alert = Color(0xFFDC2626);

  /// Main Background - EDEFFE
  static const Color background = Color(0xFFEDEFFE);
  /// second Background - F8FAFF
  static const Color secondBackground = Color(0xffF8FAFF);

  /// Small Text - 1E1E1E
  static const Color smallText = Color(0xFF1E1E1E);

  /// Icon / Accent Yellow - FFC93C
  static const Color icon = Color(0xFFFFC93C);

  /// Deactivation / Disabled Grey - 9CA3AF
  static const Color deactivation = Color(0xFF9CA3AF);

  /// Sign Up Accent / Border - E6E6E6
  static const Color signUp = Color(0xFFF8FAFF);

  // ================= Base Neutrals =================
  static const Color white100 = Color(0xFFFFFFFF);
  static const Color black100 = Color(0xFF000000);

  // ================= Aliases & Backwards Compatibility =================
  static const Color primary700 = primary;
  static const Color primary600 = Color(0xFF4758E0);
  static const Color primary500 = Color(0xFF4E61F6);
  static const Color primary50 = background;
  static const Color primaryGreen = accept;

  static const Color success = accept;
  static const Color danger = alert;
  static const Color danger500 = alert;

  static const Color grey = deactivation;
  static const Color darkGrey = Color(0xFF4D5461);
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = signUp;
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = deactivation;
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = smallText;

  static const Color accent = icon;

  // ================= Project Status Palette =================
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusInProgress = accept;
  static const Color statusCompleted = Color(0xFF10B981);
  static const Color statusCancelled = alert;
  static const Color statusOnHold = Color(0xFF6B7280);
  static const Color statusUnderReview = Color(0xFF3B82F6);
  static const Color statusApproved = Color(0xFF8B5CF6);
  static const Color statusRejected = alert;
}
