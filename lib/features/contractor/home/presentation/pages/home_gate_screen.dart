import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/home/presentation/pages/contractor_main_layout_screen.dart';

class HomeGateScreen extends StatelessWidget {
  const HomeGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cacheHelper = sl<CacheHelper>();
    final secureStorage = sl<SecureStorageHelper>();

    return FutureBuilder<String?>(
      future: secureStorage.read(key: CacheKeys.token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFFF6F8FA),
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        final token = snapshot.data;
        final rawUserType = cacheHelper.getData(key: CacheKeys.userType);
        final userRole = cacheHelper.getData(key: CacheKeys.userRole) as String?;

        int? userType;
        if (rawUserType is int) {
          userType = rawUserType;
        } else if (rawUserType != null) {
          userType = int.tryParse(rawUserType.toString());
        }

        // 1. Check user type (Contractor is userType == 2 or role == 'Contractor')
        // In local development / testing without login, default to Contractor
        final bool isContractor = userType == 2 ||
            (userRole != null &&
                userRole.toLowerCase().contains('contractor')) ||
            (token == null && userType == null);

        if (isContractor) {
          return const ContractorMainLayoutScreen();
        }

        // 2. User is logged in as another role (Project Owner, Engineer, etc.)
        final roleTitle = userRole ?? (userType == 1 ? 'Project Owner' : 'Specialist');

        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FA),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.engineering_rounded,
                      size: 64.r,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Contractor Portal Only',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1D1D1F),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'You are currently logged in as a "$roleTitle". The screens for this role are under development. Only Contractor screens are currently accessible.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF8E8E93),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  AppElevatedButton(
                    title: 'Switch Account / Log In',
                    onPressed: () {
                      context.go(AppRoutes.loginScreen);
                    },
                    width: double.infinity,
                  ),
                  SizedBox(height: 12.h),
                  TextButton(
                    onPressed: () {
                      // Allow testing contractor view directly
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ContractorMainLayoutScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Preview Contractor Home Anyway',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
