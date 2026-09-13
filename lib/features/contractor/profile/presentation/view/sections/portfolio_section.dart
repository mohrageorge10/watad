import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/section_card_widget.dart';

class PortfolioSection extends StatelessWidget {
  final ContractorProfileEntity profile;
  final VoidCallback? onViewAllTap;

  const PortfolioSection({
    super.key,
    required this.profile,
    this.onViewAllTap,
  });

  Widget _buildProjectMiniCard(
      BuildContext context, PortfolioProjectItemModel project) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.portfolioProjectDetails, extra: project);
      },
      child: Container(
        width: 140.w,
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F8FA),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFE5E5EA),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                width: double.infinity,
                height: 80.h,
                color: const Color(0xFFEDEFFE),
                child: project.image.isNotEmpty &&
                        (project.image.startsWith('http') ||
                            File(project.image).existsSync())
                    ? (project.image.startsWith('http')
                        ? Image.network(
                            project.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholder(),
                          )
                        : Image.file(
                            File(project.image),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholder(),
                          ))
                    : _buildPlaceholder(),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              project.title.isNotEmpty ? project.title : 'Project',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (project.location.isNotEmpty) ...[
              SizedBox(height: 2.h),
              Text(
                project.location,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: const Color(0xFF6B7280),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (project.price.isNotEmpty) ...[
              SizedBox(height: 2.h),
              Text(
                project.price,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1D1D1F),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFFEDEFFE),
      child: Center(
        child: Icon(
          Icons.apartment_rounded,
          color: AppColors.primary,
          size: 28.r,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projects = profile.portfolioProjects;
    final images = profile.portfolioImages;
    final hasProjects = projects.isNotEmpty;
    final hasImages = images.isNotEmpty;

    return SectionCardWidget(
      icon: Icons.work_outline_rounded,
      title: 'Portfolio Projects',
      actionText: (hasProjects || hasImages) ? 'View All >' : '+ Add',
      onActionTap: () async {
        if (hasProjects || hasImages) {
          if (onViewAllTap != null) {
            onViewAllTap!();
          } else {
            await context.push(
              AppRoutes.myProjects,
              extra: 1,
            );
            if (context.mounted) {
              context.read<ContractorProfileCubit>().loadProfile();
            }
          }
        } else {
          final res = await context.push(AppRoutes.addPortfolioProject);
          if (res == true && context.mounted) {
            context.read<ContractorProfileCubit>().loadProfile();
          }
        }
      },
      child: !hasProjects && !hasImages
          ? InkWell(
              onTap: () async {
                final res = await context.push(AppRoutes.addPortfolioProject);
                if (res == true && context.mounted) {
                  context.read<ContractorProfileCubit>().loadProfile();
                }
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F8FA),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFFE5E5EA),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: AppColors.primary,
                        size: 22.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No portfolio projects yet',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1D1D1F),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Tap to add projects to showcase your quality work.',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14.r,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            )
          : SizedBox(
              height: 175.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: projects.length >= 2 ? 2 : projects.length,
                itemBuilder: (context, index) {
                  return _buildProjectMiniCard(context, projects[index]);
                },
              ),
            ),
    );
  }
}
