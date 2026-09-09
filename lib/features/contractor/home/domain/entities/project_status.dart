import 'package:flutter/material.dart';
import 'package:watad/core/theme/app_colors.dart';

enum ProjectStatus {
  pending(1, 'Pending', AppColors.statusPending),
  inProgress(2, 'In Progress', AppColors.statusInProgress),
  completed(3, 'Completed', AppColors.statusCompleted),
  cancelled(4, 'Cancelled', AppColors.statusCancelled),
  onHold(5, 'On Hold', AppColors.statusOnHold),
  underReview(6, 'Under Review', AppColors.statusUnderReview),
  approved(7, 'Approved', AppColors.statusApproved),
  rejected(8, 'Rejected', AppColors.statusRejected);

  final int value;
  final String label;
  final Color color;

  const ProjectStatus(this.value, this.label, this.color);

  /// Dynamic hex color string for backwards compatibility with badges
  String get colorHex {
    final hexCode = color.toARGB32().toRadixString(16).padLeft(8, '0');
    return '#${hexCode.substring(2)}';
  }

  /// Safe conversion from API integer status (1-8) to ProjectStatus Enum
  static ProjectStatus? fromValue(int? value) {
    if (value == null) return null;
    try {
      return ProjectStatus.values.firstWhere(
        (status) => status.value == value,
      );
    } catch (_) {
      return null;
    }
  }

  /// Safe conversion from text label to ProjectStatus Enum
  static ProjectStatus? fromLabel(String? label) {
    if (label == null || label.trim().isEmpty) return null;
    final normalized = label.trim().toLowerCase();
    try {
      return ProjectStatus.values.firstWhere(
        (status) => status.label.toLowerCase() == normalized,
      );
    } catch (_) {
      return null;
    }
  }
}
