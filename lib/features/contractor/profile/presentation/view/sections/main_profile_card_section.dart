import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/shared/widgets/permission_confirmation_dialog.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';

class MainProfileCardSection extends StatelessWidget {
  final ContractorProfileEntity profile;
  final VoidCallback? onEditProfileTap;
  final ValueChanged<String>? onUpdatePhoto;
  final VoidCallback? onRemovePhoto;

  const MainProfileCardSection({
    super.key,
    required this.profile,
    this.onEditProfileTap,
    this.onUpdatePhoto,
    this.onRemovePhoto,
  });

  Future<void> _handleAvatarTap(BuildContext context) async {
    final hasPhoto = profile.profileImagePath != null &&
        profile.profileImagePath!.trim().isNotEmpty;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5EA),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  hasPhoto ? 'Profile Photo Options' : 'Add Profile Photo',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1D1D1F),
                  ),
                ),
                SizedBox(height: 16.h),
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt_rounded,
                        color: AppColors.primary, size: 20.r),
                  ),
                  title: Text(
                    hasPhoto ? 'Take New Photo' : 'Take Photo',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(bottomSheetContext).pop();
                    await _pickImageWithPermission(context, ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.photo_library_rounded,
                        color: AppColors.primary, size: 20.r),
                  ),
                  title: Text(
                    hasPhoto ? 'Choose from Gallery' : 'Choose from Gallery',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(bottomSheetContext).pop();
                    await _pickImageWithPermission(context, ImageSource.gallery);
                  },
                ),
                if (hasPhoto)
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.alert.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.delete_outline_rounded,
                          color: AppColors.alert, size: 20.r),
                    ),
                    title: Text(
                      'Remove Photo',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.alert,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(bottomSheetContext).pop();
                      onRemovePhoto?.call();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImageWithPermission(
    BuildContext context,
    ImageSource source,
  ) async {
    final isCamera = source == ImageSource.camera;
    final permissionKey = isCamera
        ? CacheKeys.cameraPermissionGranted
        : CacheKeys.galleryPermissionGranted;

    // 1. Check if user has already granted permission previously
    CacheHelper? cache;
    try {
      if (sl.isRegistered<CacheHelper>()) {
        cache = sl<CacheHelper>();
      }
    } catch (_) {}

    final bool isAlreadyGranted =
        cache != null && cache.getData(key: permissionKey) == true;

    // 2. If not granted yet (or user previously canceled/rejected), prompt user again
    if (!isAlreadyGranted) {
      final granted = await PermissionConfirmationDialog.show(
        context,
        title: isCamera ? 'Camera Access' : 'Gallery Access',
        message: isCamera
            ? 'Watad would like to access your Camera to take a new profile picture.'
            : 'Watad would like to access your Photos to choose a profile picture.',
        icon: isCamera ? Icons.camera_alt_rounded : Icons.photo_library_rounded,
      );

      // If user declined or dismissed, do nothing so they will be prompted next time
      if (!granted) return;

      // User allowed: persist to cache so they won't be asked again
      if (cache != null) {
        await cache.saveData(key: permissionKey, value: true);
      }
    }

    // 3. Proceed to pick image
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        onUpdatePhoto?.call(image.path);
      }
    } catch (_) {
      // Ignored or handled gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPhoto = profile.profileImagePath != null &&
        profile.profileImagePath!.trim().isNotEmpty;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circle Avatar with Edit/Camera badge
          GestureDetector(
            onTap: () => _handleAvatarTap(context),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 58.r,
                  height: 58.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F8FA),
                    shape: BoxShape.circle,
                    image: hasPhoto
                        ? DecorationImage(
                            image: FileImage(File(profile.profileImagePath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: !hasPhoto
                      ? Icon(
                          Icons.person_outline_rounded,
                          color: AppColors.primary,
                          size: 30.r,
                        )
                      : null,
                ),
                Positioned(
                  bottom: -2.r,
                  right: -2.r,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white100,
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.white100,
                      size: 11.r,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  profile.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF1D1D1F),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  profile.companyName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF8E8E93),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                // Rating row (Protected against any overflow)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: const Color(0xFFFFB020),
                      size: 15.r,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      profile.rating.toString(),
                      style: TextStyle(
                        color: const Color(0xFF1D1D1F),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        '(${profile.reviewsCount} reviews)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF8E8E93),
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                if (profile.isVerified) ...[
                  SizedBox(height: 4.h),
                  // Verification row (Wrapped in Flexible + FittedBox to prevent 0.05px overflow)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        color: const Color(0xFF00B368),
                        size: 15.r,
                      ),
                      SizedBox(width: 3.w),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Verified Contractor',
                            maxLines: 1,
                            style: TextStyle(
                              color: const Color(0xFF00B368),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 6.w),

          // Outlined Edit Profile Button
          InkWell(
            onTap: onEditProfileTap,
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFE5E5EA),
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit_outlined,
                    color: AppColors.primary,
                    size: 13.r,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
