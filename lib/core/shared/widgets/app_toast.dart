import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class AppToast {
  AppToast._();

  static void showError(BuildContext context, String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.error,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 4),
    ).show(context);
  }

  static void showSuccess(BuildContext context, String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void showInfo(BuildContext context, String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.info,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
