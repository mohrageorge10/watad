import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

enum ShadowedInputType {
  text,
  dropdown,
  number,
  multiline,
}

class ShadowedTextField extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final ShadowedInputType inputType;
  final int maxLines;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onDropdownChanged;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final bool readOnly;
  final String? suffixText;
  final Color? suffixColor;
  final Color? valueColor;
  final TextStyle? textStyle;

  const ShadowedTextField({
    super.key,
    required this.label,
    this.labelColor,
    this.initialValue,
    this.hintText,
    this.controller,
    this.inputType = ShadowedInputType.text,
    this.maxLines = 1,
    this.dropdownItems,
    this.onDropdownChanged,
    this.onChanged,
    this.onTap,
    this.validator,
    this.readOnly = false,
    this.suffixText,
    this.suffixColor,
    this.valueColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveLabelColor = labelColor ?? AppColors.primary;
    final isMultiline = inputType == ShadowedInputType.multiline;
    final effectiveMaxLines = isMultiline ? (maxLines > 1 ? maxLines : 4) : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // External label above the field
        Text(
          label,
          style: TextStyle(
            color: effectiveLabelColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),

        // Shadowed white container with rounded corners
        Container(
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10.r,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFE5E5EA),
              width: 1.0,
            ),
          ),
          child: inputType == ShadowedInputType.dropdown
              ? _buildDropdownField(context)
              : _buildTextFormField(context, effectiveMaxLines),
        ),
      ],
    );
  }

  Widget _buildDropdownField(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      initialValue: initialValue ?? dropdownItems?.firstOrNull,
      items: (dropdownItems ?? [initialValue ?? ''])
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: const Color(0xFF1D1D1F),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onDropdownChanged,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: const Color(0xFF8E8E93),
        size: 24.r,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xFF8E8E93),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildTextFormField(BuildContext context, int effectiveMaxLines) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      keyboardType: inputType == ShadowedInputType.number
          ? TextInputType.number
          : (inputType == ShadowedInputType.multiline
              ? TextInputType.multiline
              : TextInputType.text),
      inputFormatters: inputType == ShadowedInputType.number
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'))]
          : null,
      maxLines: effectiveMaxLines,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      style: textStyle ??
          TextStyle(
            color: valueColor ?? const Color(0xFF1D1D1F),
            fontSize: 15.sp,
            fontWeight: valueColor != null ? FontWeight.bold : FontWeight.w600,
          ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: inputType == ShadowedInputType.multiline ? 14.h : 14.h,
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xFF8E8E93),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        suffixText: suffixText,
        suffixStyle: TextStyle(
          color: suffixColor ?? const Color(0xFF8E8E93),
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
