import 'package:flutter/material.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class FormLabelWidget extends StatelessWidget {
  final String text;

  const FormLabelWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.font14SemiBoldDark.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.grey900,
      ),
    );
  }
}
