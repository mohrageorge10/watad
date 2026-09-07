import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/models/role_model.dart';
import 'package:watad/features/auth/presentation/view/sections/already_have_account_footer_section.dart';
import 'package:watad/features/auth/presentation/view/sections/sign_up_header_section.dart';
import 'package:watad/features/auth/presentation/view/sections/sign_up_personal_info_form_section.dart';

class SignUpPersonalInfoPage extends StatefulWidget {
  const SignUpPersonalInfoPage({
    super.key,
    this.role,
  });

  final RoleModel? role;

  @override
  State<SignUpPersonalInfoPage> createState() => _SignUpPersonalInfoPageState();
}

class _SignUpPersonalInfoPageState extends State<SignUpPersonalInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Navigate to Step 3 with collected data
    context.push(
      AppRoutes.signUpPassword,
      extra: {
        'role': widget.role,
        'email': _emailController.text.trim(),
        'fullName': _fullNameController.text.trim(),
        'phone': _phoneController.text.trim(),
      },
    );
  }

  void _handleLogin() {
    context.push(AppRoutes.loginScreen);
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
              const SignUpHeaderSection(currentStep: 2),
              Text(
                'Personal Information:',
                style: TextStyle(
                  color: const Color(0xFF1D1D1F),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 24.h),
              SignUpPersonalInfoFormSection(
                formKey: _formKey,
                emailController: _emailController,
                fullNameController: _fullNameController,
                phoneController: _phoneController,
                onContinuePressed: _handleContinue,
              ),
              SizedBox(height: 32.h),
              AlreadyHaveAccountFooterSection(
                onLoginPressed: _handleLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
