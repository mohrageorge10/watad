import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_confirmation_dialog.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_cubit.dart';

class PortfolioProjectDetailsScreen extends StatefulWidget {
  final PortfolioProjectItemModel project;

  const PortfolioProjectDetailsScreen({
    super.key,
    required this.project,
  });

  @override
  State<PortfolioProjectDetailsScreen> createState() =>
      _PortfolioProjectDetailsScreenState();
}

class _PortfolioProjectDetailsScreenState
    extends State<PortfolioProjectDetailsScreen> {
  late PortfolioProjectItemModel _currentProject;
  int _activeImageIndex = 0;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _currentProject = widget.project;
  }

  Future<void> _handleEdit() async {
    final result = await context.push<bool>(
      AppRoutes.addPortfolioProject,
      extra: _currentProject,
    );

    if (result == true && mounted) {
      final updated = await sl<PortfolioCubit>().getProjectDetails(_currentProject.id);
      if (updated != null && mounted) {
        setState(() {
          _currentProject = updated;
        });
      }
    }
  }

  Future<void> _confirmDelete() async {
    final confirm = await AppConfirmationDialog.show(
      context,
      title: 'Delete Project',
      message:
          'Are you sure you want to permanently delete this project from your portfolio?',
      icon: Icons.delete_forever_rounded,
      iconColor: const Color(0xFFFF3B30),
      cancelText: 'Cancel',
      confirmText: 'Delete',
      confirmButtonColor: const Color(0xFFFF3B30),
    );

    if (confirm == true && mounted) {
      setState(() {
        _isDeleting = true;
      });

      final error = await sl<PortfolioCubit>().deleteProject(_currentProject.id);

      if (!mounted) return;

      setState(() {
        _isDeleting = false;
      });

      if (error != null) {
        AppToast.showError(context, error);
      } else {
        AppToast.showSuccess(context, 'Project deleted from portfolio successfully');
        context.pop(true);
      }
    }
  }

  String _formatCompletionDate(String rawDate) {
    if (rawDate.isEmpty) return 'Completed';
    final dt = DateTime.tryParse(rawDate);
    if (dt != null) {
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
    }
    return rawDate.contains('T') ? rawDate.split('T').first : rawDate;
  }

  Widget _buildImageWidget(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else if (File(imagePath).existsSync()) {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF1E293B),
      child: Center(
        child: Icon(
          Icons.apartment_rounded,
          color: Colors.white.withValues(alpha: 0.4),
          size: 56.r,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = _currentProject.allImages;
    final hasMultipleImages = images.length > 1;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: Stack(
          children: [
            // Scrollable Content
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Stack(
                  children: [
                    // 1. Hero Image / Media Carousel (Height 340.h)
                    SizedBox(
                      height: 340.h,
                      width: double.infinity,
                      child: images.isNotEmpty
                          ? PageView.builder(
                              itemCount: images.length,
                              onPageChanged: (idx) {
                                setState(() {
                                  _activeImageIndex = idx;
                                });
                              },
                              itemBuilder: (context, index) {
                                return _buildImageWidget(images[index]);
                              },
                            )
                          : _buildPlaceholder(),
                    ),

                    // Gradient overlays for contrast (wrapped in IgnorePointer so gestures pass to PageView)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 100.h,
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.55),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 220.h,
                      left: 0,
                      right: 0,
                      height: 120.h,
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.6),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Carousel Dots Indicator (wrapped in IgnorePointer)
                    if (hasMultipleImages)
                      Positioned(
                        top: 275.h,
                        left: 0,
                        right: 0,
                        child: IgnorePointer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(images.length, (idx) {
                              final isActive = idx == _activeImageIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                width: isActive ? 22.w : 6.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  color:
                                      isActive ? Colors.white : Colors.white60,
                                  borderRadius: BorderRadius.circular(4.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),

                    // 2. Overlapping Card Sheet
                    Container(
                      margin: EdgeInsets.only(top: 305.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 18.r,
                            offset: const Offset(0, -6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Drag Handle Pill
                            Center(
                              child: Container(
                                width: 44.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCBD5E1),
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                              ),
                            ),
                            SizedBox(height: 18.h),

                            // Status Badge Row
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFECFDF5),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: const Color(0xFFA7F3D0),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        size: 14.r,
                                        color: const Color(0xFF10B981),
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        _currentProject.badgeText.isNotEmpty
                                            ? _currentProject.badgeText
                                            : 'Completed',
                                        style: TextStyle(
                                          color: const Color(0xFF065F46),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),

                            // Project Title
                            Text(
                              _currentProject.title.isNotEmpty
                                  ? _currentProject.title
                                  : 'Project Details',
                              style: TextStyle(
                                color: const Color(0xFF0F172A),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                                height: 1.25,
                              ),
                            ),

                            // Location Chip Row
                            if (_currentProject.location.isNotEmpty) ...[
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: AppColors.primary,
                                    size: 16.r,
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Text(
                                      _currentProject.location,
                                      style: TextStyle(
                                        color: const Color(0xFF64748B),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            SizedBox(height: 20.h),

                            // Key Metrics Row (Cost & Completion)
                            Row(
                              children: [
                                Expanded(
                                  child: _buildMetricCard(
                                    icon: Icons.payments_rounded,
                                    iconColor: AppColors.primary,
                                    label: 'PROJECT COST',
                                    value: _currentProject.price.isNotEmpty
                                        ? _currentProject.price
                                        : (_currentProject.projectCost != null
                                            ? 'EGP ${_currentProject.projectCost!.toStringAsFixed(0)}'
                                            : 'N/A'),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: _buildMetricCard(
                                    icon: Icons.calendar_month_rounded,
                                    iconColor: const Color(0xFF10B981),
                                    label: 'COMPLETION DATE',
                                    value: _formatCompletionDate(
                                        _currentProject.date),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),

                            // Technical Description & Scope Section
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6.r),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Icons.architecture_rounded,
                                    size: 18.r,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Technical Description & Scope',
                                  style: TextStyle(
                                    color: const Color(0xFF0F172A),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(18.r),
                              decoration: BoxDecoration(
                                color: AppColors.white100,
                                borderRadius: BorderRadius.circular(18.r),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 10.r,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                _currentProject.description.isNotEmpty
                                    ? _currentProject.description
                                    : 'Comprehensive turnkey execution adhering to Watad structural specifications, premium reinforced concrete foundation, integrated MEP installations, and high-end exterior architectural finishing.',
                                style: TextStyle(
                                  color: const Color(0xFF334155),
                                  fontSize: 14.sp,
                                  height: 1.65,
                                ),
                              ),
                            ),

                            // Bottom breathing room for sticky bar
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Floating Glass Back Button & Counter (Top Header Bar)
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Circular Frosted Glass Back Button
                    InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(24.r),
                      child: Container(
                        width: 42.r,
                        height: 42.r,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18.r,
                          ),
                        ),
                      ),
                    ),

                    // Image Counter Badge if multiple images
                    if (hasMultipleImages)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              size: 14.r,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              '${_activeImageIndex + 1}/${images.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // 4. Fixed Bottom Action Bar
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColors.white100,
            border: const Border(
              top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 16.r,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                // Edit Button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _handleEdit,
                    icon: Icon(Icons.edit_note_rounded, size: 20.r),
                    label: Text(
                      'Edit Project',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Delete Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isDeleting ? null : _confirmDelete,
                    icon: _isDeleting
                        ? SizedBox(
                            width: 16.r,
                            height: 16.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Icon(Icons.delete_outline_rounded, size: 20.r),
                    label: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(7.r),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 18.r, color: iconColor),
          ),
          SizedBox(height: 10.h),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF64748B),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF0F172A),
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
