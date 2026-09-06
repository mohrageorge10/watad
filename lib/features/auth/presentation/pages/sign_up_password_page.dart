import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/models/role_model.dart';
import 'package:watad/features/auth/presentation/view/sections/sign_up_header_section.dart';
import 'package:watad/features/auth/presentation/view/sections/sign_up_password_form_section.dart';

class SignUpPasswordPage extends StatefulWidget {
  const SignUpPasswordPage({
    super.key,
    this.role,
    this.email,
    this.fullName,
    this.phone,
  });

  final RoleModel? role;
  final String? email;
  final String? fullName;
  final String? phone;

  @override
  State<SignUpPasswordPage> createState() => _SignUpPasswordPageState();
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Navigate to Step 4 with complete signup payload
    context.push(
      AppRoutes.signUpConfirmation,
      extra: {
        'role': widget.role,
        'email': widget.email,
        'fullName': widget.fullName,
        'phone': widget.phone,
        'password': _passwordController.text,
      },
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
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            bottom: 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignUpHeaderSection(currentStep: 3),
              Text(
                'Password',
                style: TextStyle(
                  color: const Color(0xFF1D1D1F),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 24.h),
              SignUpPasswordFormSection(
                formKey: _formKey,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                onContinuePressed: _handleContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
