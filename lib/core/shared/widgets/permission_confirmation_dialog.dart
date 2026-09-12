import 'package:flutter/material.dart';
import 'package:watad/core/shared/widgets/app_confirmation_dialog.dart';

class PermissionConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const PermissionConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
  });

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required IconData icon,
  }) async {
    return AppConfirmationDialog.show(
      context,
      title: title,
      message: message,
      icon: icon,
      cancelText: 'Cancel',
      confirmText: 'Allow',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppConfirmationDialog(
      title: title,
      message: message,
      icon: icon,
      cancelText: 'Cancel',
      confirmText: 'Allow',
    );
  }
}
