import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_profile_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_profile_state.dart';
import 'package:watad/features/auth/presentation/view/change_password_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeProfileCubit>()..fetchProfile(),
      child: const _ProfileContent(),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      body: BlocBuilder<HomeProfileCubit, HomeProfileState>(
        builder: (context, state) {
          if (state is HomeProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is HomeProfileError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48.r, color: AppColors.alert),
                    SizedBox(height: 16.h),
                    Text(
                      state.failure.errMessage,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14Medium,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<HomeProfileCubit>().fetchProfile(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text('Retry',
                          style: TextStyle(color: AppColors.white100)),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is HomeProfileLoaded) {
            final profile = state.profile;
            return SingleChildScrollView(
              child: Column(
                children: [
                  // ===== Header Section =====
                  _ProfileHeader(
                    fullName: profile.fullName,
                    role: profile.role,
                    profilePictureUrl: profile.profilePictureUrl,
                  ),

                  SizedBox(height: 24.h),

                  // ===== Account Information Section =====
                  _AccountInfoSection(
                    email: profile.email,
                    phoneNumber: profile.phoneNumber,
                    role: profile.role,
                  ),

                  SizedBox(height: 32.h),

                  // ===== Actions Section =====
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Column(
                      children: [
                        // Logout Button
                        _LogoutButton(
                          onTap: () async {
                            sl<AuthCubit>().logout();
                            context.go(AppRoutes.welcome);
                          },
                        ),

                        SizedBox(height: 12.h),

                        // Change Password / Forgot Password Button
                        _ChangePasswordButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChangePasswordView(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ===================================================================
// Header Section
// ===================================================================
class _ProfileHeader extends StatelessWidget {
  final String fullName;
  final String role;
  final String? profilePictureUrl;

  const _ProfileHeader({
    required this.fullName,
    required this.role,
    this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Icon(Icons.arrow_back, color: AppColors.white100, size: 24.r),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.edit_outlined, color: AppColors.white100, size: 22.r),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.w, top: 4.h, bottom: 16.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white100,
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: 84.r,
                  height: 84.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey200,
                  ),
                  child: ClipOval(
                    child: profilePictureUrl != null && profilePictureUrl!.isNotEmpty
                        ? Image.network(
                      profilePictureUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(Icons.person, size: 48.r, color: AppColors.deactivation),
                    )
                        : Icon(Icons.person, size: 48.r, color: AppColors.deactivation),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 24.r,
                    height: 24.r,
                    decoration: const BoxDecoration(
                      color: AppColors.white100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, size: 13.r, color: AppColors.primary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              fullName,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white100,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Property Owner',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.white100.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 28.h),
          ],
        ),
      ),
    );
  }
}

// ===================================================================
// Account Info Section
// ===================================================================
class _AccountInfoSection extends StatelessWidget {
  final String email;
  final String phoneNumber;
  final String role;

  const _AccountInfoSection({
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline_rounded, size: 18.r, color: AppColors.primary),
              SizedBox(width: 8.w),
              Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.smallText,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                _InfoTile(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  value: email,
                ),
                Divider(height: 1, thickness: 0.5, color: AppColors.grey200, indent: 48.w),
                _InfoTile(
                  icon: Icons.phone_outlined,
                  title: 'Phone Number',
                  value: phoneNumber,
                ),
                Divider(height: 1, thickness: 0.5, color: AppColors.grey200, indent: 48.w),
                _InfoTile(
                  icon: Icons.trip_origin_outlined,
                  title: 'Role',
                  value: role,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Icon(icon, color: AppColors.deactivation, size: 20.r),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.smallText,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.smallText,
            ),
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// Action Buttons
// ===================================================================
class _LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.alert, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: AppColors.alert, size: 18.r),
            SizedBox(width: 8.w),
            Text(
              'Log Out',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.alert,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangePasswordButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ChangePasswordButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 18.r),
            SizedBox(width: 8.w),
            Text(
              'Change Password',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}