import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_confirmation_dialog.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_cubit.dart';
import 'package:watad/features/contractor/portfolio/presentation/view/widgets/portfolio_status_badge.dart';

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
      title: 'حذف المشروع',
      message: 'هل أنت متأكد من رغبتك في حذف هذا المشروع من سابقة أعمالك نهائياً؟',
      icon: Icons.delete_forever_rounded,
      iconColor: const Color(0xFFFF3B30),
      cancelText: 'إلغاء',
      confirmText: 'حذف',
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
        AppToast.showSuccess(context, 'تم حذف المشروع من سابقة الأعمال بنجاح');
        context.pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = _currentProject.allImages;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white100,
                      size: 20.r,
                    ),
                    splashRadius: 22.r,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      _currentProject.title,
                      style: TextStyle(
                        color: AppColors.white100,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Media Slider / Cover Image
            if (images.isNotEmpty)
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 240.h,
                    width: double.infinity,
                    child: PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (idx) {
                        setState(() {
                          _activeImageIndex = idx;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.grey200,
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.grey500,
                                size: 48.r,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (images.length > 1)
                    Positioned(
                      bottom: 12.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(images.length, (idx) {
                          final isActive = idx == _activeImageIndex;
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: isActive ? 18.w : 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: isActive ? AppColors.white100 : Colors.white60,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          );
                        }),
                      ),
                    ),
                ],
              ),

            // Content Body
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Badge Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          _currentProject.title,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      PortfolioStatusBadge(
                        text: _currentProject.badgeText,
                        type: _currentProject.badgeType,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),

                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primary600,
                        size: 18.r,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        _currentProject.location,
                        style: TextStyle(
                          color: AppColors.grey600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),

                  // Info Cards Row (Cost & Completion Date)
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.payments_outlined,
                          title: 'Project Cost',
                          value: _currentProject.price.isNotEmpty
                              ? _currentProject.price
                              : 'EGP ${_currentProject.projectCost?.toStringAsFixed(0) ?? 'N/A'}',
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.calendar_today_outlined,
                          title: 'Completion',
                          value: _currentProject.date.isNotEmpty
                              ? _currentProject.date
                              : 'Completed',
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Technical Description Section
                  Text(
                    'Technical Description & Scope',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.white100,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColors.grey200),
                    ),
                    child: Text(
                      _currentProject.description.isNotEmpty
                          ? _currentProject.description
                          : 'Comprehensive turnkey execution adhering to Watad structural specifications, premium reinforced concrete foundation, integrated MEP installations, and high-end exterior architectural finishing.',
                      style: TextStyle(
                        color: AppColors.grey800,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Actions Row: Edit Project & Delete Project
                  Row(
                    children: [
                      // Edit Button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _handleEdit,
                          icon: Icon(Icons.edit_outlined, size: 18.r),
                          label: Text(
                            'Edit Project',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary, width: 1.5),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
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
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Icon(Icons.delete_outline_rounded, size: 18.r),
                          label: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade600,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16.r, color: color),
              SizedBox(width: 6.w),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.grey500,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
