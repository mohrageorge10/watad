import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class AuthTextFieldWidget extends StatefulWidget {
  const AuthTextFieldWidget({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;

  @override
  State<AuthTextFieldWidget> createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000), // subtle elevation 2 shadow
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
        onChanged: widget.onChanged,
        style: TextStyle(
          fontSize: 15.sp,
          color: const Color(0xFF1D1D1F),
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontSize: 12.sp,
            color: AppColors.alert,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: AppColors.grey500,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
          ),
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: widget.prefixIcon,
                )
              : null,
          prefixIconConstraints: BoxConstraints(
            minWidth: 48.w,
            minHeight: 24.h,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.grey500,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : (widget.suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: widget.suffixIcon,
                    )
                  : null),
          suffixIconConstraints: BoxConstraints(
            minWidth: 48.w,
            minHeight: 24.h,
          ),
          filled: true,
          fillColor: AppColors.white100,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: AppColors.alert, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: AppColors.alert, width: 1.5),
          ),
        ),
      ),
    );
  }
}
