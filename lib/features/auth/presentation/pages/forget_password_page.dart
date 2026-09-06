import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/presentation/view/sections/forget_password_form_section.dart';
import 'package:watad/features/auth/presentation/view/sections/forget_password_header_section.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSendResetCode() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();

    setState(() => _isLoading = true);

    // Simulate sending reset code email via API
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isLoading = false);

    AppToast.showSuccess(
      context,
      'Reset code sent to your email, please check your inbox!',
    );

    context.push(
      AppRoutes.otpScreen,
      extra: {'email': email},
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
              const ForgetPasswordHeaderSection(),
              ForgetPasswordFormSection(
                formKey: _formKey,
                emailController: _emailController,
                isLoading: _isLoading,
                onContinuePressed: _handleSendResetCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
