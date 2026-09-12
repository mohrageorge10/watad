import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/auth/presentation/view/new_password_view.dart';

class ChangePasswordOtpView extends StatefulWidget {
  final String email;

  const ChangePasswordOtpView({
    super.key,
    required this.email,
  });

  @override
  State<ChangePasswordOtpView> createState() => _ChangePasswordOtpViewState();
}

class _ChangePasswordOtpViewState extends State<ChangePasswordOtpView> {
  final _otpController = TextEditingController();
  Timer? _resendTimer;
  int _remainingSeconds = 60;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() {
      _remainingSeconds = 60;
    });

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _onContinue() {
    final otp = _otpController.text.trim();
    if (otp.length == 6) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewPasswordView(otpCode: otp),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 54.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1D1D1F),
        fontFamily: 'Inter',
      ),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.grey200),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.white100,
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.white100,
      appBar: AppBar(
        backgroundColor: AppColors.white100,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.r),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Email Confirmation',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.r),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.signUp,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.grey200, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.email_outlined, color: AppColors.primary, size: 24.r),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Enter the 6-digit code sent to your email\naddress',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.smallText,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Email Label
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.smallText,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                widget.email.isNotEmpty ? widget.email : 'john.owner@email.com',
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.deactivation,
                ),
              ),

              SizedBox(height: 32.h),

              // OTP Label
              Text(
                'Enter 6-digit code',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.smallText,
                ),
              ),
              SizedBox(height: 16.h),

              // Pinput OTP Field
              Center(
                child: Pinput(
                  length: 6,
                  controller: _otpController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  onCompleted: (_) => _onContinue(),
                  keyboardType: TextInputType.number,
                ),
              ),

              SizedBox(height: 24.h),

              // Resend OTP
              Center(
                child: _remainingSeconds > 0
                    ? Text(
                        "Resend code in $_remainingSeconds s",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.deactivation,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _startResendTimer();
                          // TODO: Call resend OTP API
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Didn't receive OTP? ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.deactivation,
                            ),
                            children: [
                              TextSpan(
                                text: 'Resend Code',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),

              SizedBox(height: 40.h),

              // Continue Button
              AppElevatedButton(
                title: 'Continue',
                onPressed: _otpController.text.length == 6 ? _onContinue : null,
                width: double.infinity,
                height: 52,
                textStyle: AppTextStyles.font16SemiBold.copyWith(
                  color: AppColors.white100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
