import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_details_entity.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/marketplace_attachment_tile.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/marketplace_detail_item.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/marketplace_image_gallery.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/marketplace_spec_card.dart';

class MarketplaceDetailsCardSection extends StatelessWidget {
  final MarketplaceProjectDetailsEntity project;
  final VoidCallback? onSubmitBidTap;
  final ValueChanged<MarketplaceAttachmentEntity>? onAttachmentTap;

  const MarketplaceDetailsCardSection({
    super.key,
    required this.project,
    this.onSubmitBidTap,
    this.onAttachmentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Image Gallery
          MarketplaceImageGallery(images: project.images),

          SizedBox(height: 20.h),

          // 2. Title & Status Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  project.title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1D1D1F),
                    height: 1.25,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B368),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  project.status,
                  style: TextStyle(
                    color: AppColors.white100,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Location Row
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: const Color(0xFF8E8E93),
                size: 16.r,
              ),
              SizedBox(width: 4.w),
              Text(
                project.location,
                style: TextStyle(
                  color: const Color(0xFF1D1D1F),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // 3. Specs Row (Land Area, Floors, Finishing Level)
          Row(
            children: [
              for (int i = 0; i < project.specs.length; i++) ...[
                if (i > 0) SizedBox(width: 8.w),
                Expanded(
                  child: MarketplaceSpecCard.fromStringIcon(
                    iconName: project.specs[i].icon,
                    label: project.specs[i].label,
                    value: project.specs[i].value,
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: 24.h),

          // 4. Key Details Grid (2x2)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MarketplaceDetailItem(
                  label: 'Estimated Budget',
                  value: project.estimatedBudget,
                  valueColor: AppColors.primary,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: MarketplaceDetailItem(
                  label: 'Expected Duration',
                  value: project.expectedDuration,
                  icon: Icons.access_time_rounded,
                  valueColor: AppColors.primary,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MarketplaceDetailItem(
                  label: 'Start Date',
                  value: project.startDate,
                  icon: Icons.calendar_today_outlined,
                  valueColor: AppColors.primary,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: MarketplaceDetailItem(
                  label: 'Completion Date',
                  value: project.completionDate,
                  icon: Icons.calendar_today_outlined,
                  valueColor: AppColors.primary,
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // 5. Description Section
          Text(
            'Description',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D1D1F),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            project.description,
            style: TextStyle(
              color: const Color(0xFF8E8E93),
              fontSize: 14.sp,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: 24.h),

          // 6. Attachments Section
          Text(
            'Attachments',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D1D1F),
            ),
          ),
          SizedBox(height: 12.h),
          for (int i = 0; i < project.attachments.length; i++) ...[
            if (i > 0) SizedBox(height: 12.h),
            MarketplaceAttachmentTile(
              title: project.attachments[i].title,
              size: project.attachments[i].size,
              onTap: () {
                if (onAttachmentTap != null) {
                  onAttachmentTap!(project.attachments[i]);
                }
              },
            ),
          ],

          SizedBox(height: 32.h),

          // 7. Action Button ("Submit a Bid")
          AppElevatedButton(
            title: 'Submit a Bid',
            onPressed: onSubmitBidTap ?? () {},
            backgroundColor: AppColors.primary,
            borderRadius: 12.r,
            height: 50.h,
            textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white100,
            ),
          ),
        ],
      ),
    );
  }
}
