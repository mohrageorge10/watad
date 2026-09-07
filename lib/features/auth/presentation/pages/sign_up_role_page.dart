import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/mock/role_mock_data.dart';
import 'package:watad/features/auth/data/models/role_model.dart';
import 'package:watad/features/auth/presentation/view/sections/already_have_account_footer_section.dart';
import 'package:watad/features/auth/presentation/view/sections/role_selection_list_section.dart';
import 'package:watad/features/auth/presentation/view/sections/sign_up_header_section.dart';

class SignUpRolePage extends StatefulWidget {
  const SignUpRolePage({super.key});

  @override
  State<SignUpRolePage> createState() => _SignUpRolePageState();
}

class _SignUpRolePageState extends State<SignUpRolePage> {
  RoleModel? _selectedRole;

  @override
  void initState() {
    super.initState();
    if (RoleMockData.roles.isNotEmpty) {
      _selectedRole = RoleMockData.roles.first;
    }
  }

  void _handleContinue() {
    if (_selectedRole == null) {
      AppToast.showError(context, 'Please select your role');
      return;
    }

    // Navigate to Step 2 with the selected role
    context.push(
      AppRoutes.signUpPersonalInfo,
      extra: {'role': _selectedRole},
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
              const SignUpHeaderSection(currentStep: 1),
              Text(
                'Your Role :',
                style: TextStyle(
                  color: const Color(0xFF1D1D1F),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 24.h),
              RoleSelectionListSection(
                roles: RoleMockData.roles,
                selectedRole: _selectedRole,
                onRoleSelected: (role) {
                  setState(() {
                    _selectedRole = role;
                  });
                },
              ),
              SizedBox(height: 16.h),
              AppElevatedButton(
                title: 'Continue',
                onPressed: _handleContinue,
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
