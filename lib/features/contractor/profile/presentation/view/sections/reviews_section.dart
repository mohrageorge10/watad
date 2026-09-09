import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/profile/data/models/review_model.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';

class ReviewsSection extends StatelessWidget {
  final ContractorProfileEntity profile;
  final List<ReviewModel> reviews;

  const ReviewsSection({
    super.key,
    required this.profile,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating Summary Card
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFFE5E5EA),
                width: 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          profile.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1D1D1F),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '/ 5.0',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF8E8E93),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < profile.rating.floor()
                              ? Icons.star_rounded
                              : (index < profile.rating
                                  ? Icons.star_half_rounded
                                  : Icons.star_outline_rounded),
                          color: const Color(0xFFFFC107),
                          size: 20.r,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Based on ${reviews.length} reviews',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF8E8E93),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.accept.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified_user_rounded,
                    color: AppColors.accept,
                    size: 32.r,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Section Title
          Text(
            'Client Reviews',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1D1D1F),
            ),
          ),
          SizedBox(height: 12.h),

          // Reviews List
          if (reviews.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: AppColors.white100,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFE5E5EA)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    size: 40.r,
                    color: const Color(0xFF8E8E93),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'No reviews yet',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1D1D1F),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Completed project reviews will appear here.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF8E8E93),
                    ),
                  ),
                ],
              ),
            )
          else
            ...reviews.map((review) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.white100,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFFE5E5EA),
                      width: 1.w,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18.r,
                            backgroundColor: const Color(0xFFEDEFFE),
                            child: Text(
                              review.reviewerName.isNotEmpty
                                  ? review.reviewerName[0].toUpperCase()
                                  : 'C',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.reviewerName,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1D1D1F),
                                  ),
                                ),
                                if (review.projectName != null) ...[
                                  SizedBox(height: 2.h),
                                  Text(
                                    review.projectName!,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Text(
                            review.date,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < review.rating.floor()
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: const Color(0xFFFFC107),
                            size: 16.r,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        review.comment,
                        style: TextStyle(
                          fontSize: 13.sp,
                          height: 1.4,
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
