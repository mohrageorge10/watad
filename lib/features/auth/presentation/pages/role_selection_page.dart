import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/mock/role_mock_data.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/data/models/role_model.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/auth/presentation/cubit/auth_state.dart';
import 'package:watad/features/auth/presentation/view/sections/role_selection_footer_section.dart';
import 'package:watad/features/auth/presentation/view/sections/role_selection_header_section.dart';
import 'package:watad/features/auth/presentation/view/sections/role_selection_list_section.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({
    super.key,
    this.authProvider,
    this.authToken,
  });

  final String? authProvider;
  final String? authToken;

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  RoleModel? _selectedRole;

  @override
  void initState() {
    super.initState();
    if (RoleMockData.roles.isNotEmpty) {
      _selectedRole = RoleMockData.roles.first;
    }
  }

  void _onRoleSelected(RoleModel role) {
    setState(() {
      _selectedRole = role;
    });
  }

  void _handleContinue(BuildContext cubitContext) {
    if (_selectedRole == null) {
      AppToast.showError(context, 'Please select a role first');
      return;
    }

    final token = widget.authToken ?? 'token_placeholder';
    final userType = _selectedRole!.userType;

    if (widget.authProvider == 'facebook') {
      cubitContext.read<AuthCubit>().facebookLogin(
            FacebookLoginRequestModel(
              accessToken: token,
              userType: userType,
            ),
          );
    } else {
      // Default to Google Login
      cubitContext.read<AuthCubit>().googleLogin(
            GoogleLoginRequestModel(
              idToken: token,
              userType: userType,
            ),
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
              if (state is SocialLoginSuccessState) {
                final msg = state.response.message.isNotEmpty
                    ? state.response.message
                    : 'Logged in successfully as ${_selectedRole!.title}';
                AppToast.showSuccess(context, msg);
                context.go(AppRoutes.projectDashboard);
              } else if (state is AuthErrorState) {
                AppToast.showError(context, state.message);
              }
            },
            builder: (context, state) {
              final bool isLoading = state is AuthLoading;

              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 420.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const RoleSelectionHeaderSection(),
                        RoleSelectionListSection(
                          roles: RoleMockData.roles,
                          selectedRole: _selectedRole,
                          onRoleSelected: _onRoleSelected,
                        ),
                        RoleSelectionFooterSection(
                          isLoading: isLoading,
                          isEnabled: _selectedRole != null,
                          onContinuePressed: () => _handleContinue(context),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
