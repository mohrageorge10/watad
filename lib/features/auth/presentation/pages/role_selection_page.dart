import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/mock/role_mock_data.dart';
import 'package:watad/features/auth/data/models/role_model.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Default to first role or leave null for user selection
    if (RoleMockData.roles.isNotEmpty) {
      _selectedRole = RoleMockData.roles.first;
    }
  }

  void _onRoleSelected(RoleModel role) {
    setState(() {
      _selectedRole = role;
    });
  }

  Future<void> _handleContinue() async {
    if (_selectedRole == null) {
      AppToast.showError(context, 'Please select a role first');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate API Authentication with role selection
      await Future.delayed(const Duration(milliseconds: 1000));

      final mockJwtToken = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';

      // Save token to Secure Storage
      final secureStorage = sl<SecureStorageHelper>();
      await secureStorage.write(key: ApiKey.token, value: mockJwtToken);

      if (!mounted) return;
      AppToast.showSuccess(context, 'Logged in successfully as ${_selectedRole!.title}');

      // Navigate to Home or next destination
      context.go(AppRoutes.home);
    } catch (e) {
      if (mounted) {
        AppToast.showError(context, 'Authentication failed: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
        child: Center(
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
                    isLoading: _isLoading,
                    isEnabled: _selectedRole != null,
                    onContinuePressed: _handleContinue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
