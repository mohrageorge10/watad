import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/home/data/mock/home_mock_data.dart';
import '../widgets/circular_action_button.dart';

class ExploreServicesSection extends StatelessWidget {
  final List<ServiceCategoryModel> services;

  const ExploreServicesSection({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Explore Services", style: AppTextStyles.font18SemiBoldDark),
              Text("View All", style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.primary)),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final service = services[index];
              return Container(
                width: 140.w,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      style: AppTextStyles.font14SemiBoldDark.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      service.subtitle,
                      style: AppTextStyles.font12RegularGrey.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.grey500,
                        height: 1.4,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircularActionButton(onTap: () {}),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
