import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/presentation/view/sections/otp_footer_section.dart';
import 'package:watad/features/auth/presentation/view/sections/otp_form_section.dart';
import 'package:watad/features/auth/presentation/view/sections/otp_header_section.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({
    super.key,
    this.email,
  });

  final String? email;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late final TextEditingController _otpController;
  bool _isLoading = false;
  Timer? _resendTimer;
  int _remainingSeconds = 60;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
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

  Future<void> _handleVerifyOtp() async {
    final otp = _otpController.text.trim();

    if (otp.length < 6) {
      AppToast.showError(context, 'Please enter the full 6-digit OTP code');
      return;
    }

    setState(() => _isLoading = true);

    // Simulate verifying OTP via API
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isLoading = false);

    context.push(
      AppRoutes.resetPasswordScreen,
      extra: {'email': widget.email, 'otp': otp},
    );
  }

  Future<void> _handleResendCode() async {
    if (_remainingSeconds > 0) return;

    _startResendTimer();

    AppToast.showInfo(
      context,
      'A new OTP code has been sent to your email!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.signUp,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1D1D1F)),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OtpHeaderSection(email: widget.email),
              OtpFormSection(
                otpController: _otpController,
                isLoading: _isLoading,
                onContinuePressed: _handleVerifyOtp,
                onCompleted: (_) => _handleVerifyOtp(),
              ),
              OtpFooterSection(
                remainingSeconds: _remainingSeconds,
                onResendCodePressed: _handleResendCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
