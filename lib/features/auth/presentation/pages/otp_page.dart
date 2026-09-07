import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/auth/presentation/cubit/auth_state.dart';
import 'package:watad/features/auth/presentation/view/sections/otp_footer_section.dart';
import 'package:watad/features/auth/presentation/view/sections/otp_form_section.dart';
import 'package:watad/features/auth/presentation/view/sections/otp_header_section.dart';
import 'package:watad/features/auth/presentation/view/widgets/spam_folder_hint_widget.dart';

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

  void _handleVerifyOtp(BuildContext cubitContext) {
    final otp = _otpController.text.trim();

    if (otp.length < 6) {
      AppToast.showError(context, 'Please enter the full 6-digit OTP code');
      return;
    }

    cubitContext.read<AuthCubit>().verifyOtp(
          VerifyOtpRequestModel(
            email: widget.email ?? '',
            otp: otp,
          ),
        );
  }

  void _handleResendCode(BuildContext cubitContext) {
    if (_remainingSeconds > 0) return;

    _startResendTimer();
    if (widget.email != null && widget.email!.isNotEmpty) {
      cubitContext.read<AuthCubit>().forgotPassword(
            ForgotPasswordRequestModel(email: widget.email!),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              if (state is VerifyOtpSuccessState) {
                AppToast.showSuccess(
                  context,
                  state.message.isNotEmpty
                      ? state.message
                      : 'OTP verified successfully!',
                );
                context.push(
                  AppRoutes.resetPasswordScreen,
                  extra: {
                    'email': widget.email,
                    'otp': state.resetToken,
                  },
                );
              } else if (state is ForgotPasswordSuccessState) {
                AppToast.showSuccess(
                  context,
                  'A new OTP code has been sent to your email!',
                );
              } else if (state is AuthErrorState) {
                AppToast.showError(context, state.message);
              }
            },
            builder: (context, state) {
              final bool isLoading = state is AuthLoading;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OtpHeaderSection(email: widget.email),
                    const SpamFolderHintWidget(),
                    OtpFormSection(
                      otpController: _otpController,
                      isLoading: isLoading,
                      onContinuePressed: () => _handleVerifyOtp(context),
                      onCompleted: (_) => _handleVerifyOtp(context),
                    ),
                    OtpFooterSection(
                      remainingSeconds: _remainingSeconds,
                      onResendCodePressed: () => _handleResendCode(context),
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
