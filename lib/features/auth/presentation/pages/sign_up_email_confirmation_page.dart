import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/data/models/role_model.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/auth/presentation/cubit/auth_state.dart';
import 'package:watad/features/auth/presentation/view/sections/sign_up_confirmation_footer_section.dart';
import 'package:watad/features/auth/presentation/view/sections/sign_up_header_section.dart';
import 'package:watad/features/auth/presentation/view/widgets/spam_folder_hint_widget.dart';

class SignUpEmailConfirmationPage extends StatefulWidget {
  const SignUpEmailConfirmationPage({
    super.key,
    this.role,
    this.email,
    this.fullName,
    this.phone,
    this.password,
  });

  final RoleModel? role;
  final String? email;
  final String? fullName;
  final String? phone;
  final String? password;

  @override
  State<SignUpEmailConfirmationPage> createState() =>
      _SignUpEmailConfirmationPageState();
}

class _SignUpEmailConfirmationPageState
    extends State<SignUpEmailConfirmationPage> {
  late final TextEditingController _otpController;
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

  String _maskEmail(String? email) {
    if (email == null || email.isEmpty || !email.contains('@')) {
      return 'cs*********@**';
    }
    final parts = email.split('@');
    final name = parts[0];
    final domain = parts[1];

    final visibleName = name.length > 2 ? name.substring(0, 2) : name;
    final maskedName = visibleName.padRight(name.length, '*');

    final visibleDomain = domain.length > 2 ? domain.substring(0, 2) : domain;
    final maskedDomain = visibleDomain.padRight(domain.length, '*');

    return '$maskedName@$maskedDomain';
  }

  void _handleConfirm(BuildContext cubitContext) {
    final otp = _otpController.text.trim();

    if (otp.length < 6) {
      AppToast.showError(context, 'Please enter the full 6-digit OTP code');
      return;
    }

    cubitContext.read<AuthCubit>().confirmEmail(
          ConfirmEmailRequestModel(
            email: widget.email ?? '',
            otp: otp,
          ),
        );
  }

  void _handleResendCode(BuildContext cubitContext) {
    if (_remainingSeconds > 0) return;

    if (widget.email != null && widget.email!.isNotEmpty) {
      _startResendTimer();
      cubitContext.read<AuthCubit>().resendOtp(widget.email!);
    } else {
      AppToast.showError(context, 'Email is missing, please try signing up again.');
    }
  }

  void _showTermsDialog() {
    AppToast.showInfo(context, 'Terms of Use');
  }

  void _showPrivacyDialog() {
    AppToast.showInfo(context, 'Privacy Policy');
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
        border: Border.all(color: Colors.transparent),
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
        border: Border.all(color: AppColors.accept, width: 1.5),
      ),
    );

    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: Scaffold(
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
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ConfirmEmailSuccessState) {
                final msg = state.response.message.isNotEmpty
                    ? state.response.message
                    : 'Account confirmed successfully! Welcome to Watad!';
                AppToast.showSuccess(context, msg);
                // Token and expiration date are automatically saved by AuthCubit!
                context.go(AppRoutes.home);
              } else if (state is ResendOtpSuccessState) {
                final msg = state.message.isNotEmpty
                    ? state.message
                    : 'A new activation code has been sent to your email!';
                AppToast.showSuccess(context, msg);
              } else if (state is AuthErrorState) {
                AppToast.showError(context, state.message);
              }
            },
            builder: (context, state) {
              final bool isLoading = state is AuthLoading;

              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  bottom: 24.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SignUpHeaderSection(currentStep: 4),
                    Text(
                      'Email Confirmation:',
                      style: TextStyle(
                        color: const Color(0xFF1D1D1F),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "We've sent a message with an activation code to your email ${_maskEmail(widget.email)}",
                      style: TextStyle(
                        color: const Color(0xFF8E8E93),
                        fontSize: 14.sp,
                        height: 1.5,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SpamFolderHintWidget(),
                    SizedBox(height: 16.h),
                    Center(
                      child: Pinput(
                        length: 6,
                        controller: _otpController,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        onCompleted: (_) => _handleConfirm(context),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 36.h),
                    AppElevatedButton(
                      title: 'Confirm',
                      isLoading: isLoading,
                      onPressed: () => _handleConfirm(context),
                      backgroundColor: AppColors.primary,
                      borderRadius: 12,
                      height: 54,
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white100,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 32.h),
                    SignUpConfirmationFooterSection(
                      remainingSeconds: _remainingSeconds,
                      onResendCodePressed: () => _handleResendCode(context),
                      onTermsPressed: _showTermsDialog,
                      onPrivacyPressed: _showPrivacyDialog,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
