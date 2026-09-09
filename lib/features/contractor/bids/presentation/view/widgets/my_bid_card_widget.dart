import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';

class MyBidCardWidget extends StatelessWidget {
  final MyBidEntity bid;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onEditBidTap;
  final VoidCallback? onWithdrawTap;
  final VoidCallback? onViewContractTap;

  const MyBidCardWidget({
    super.key,
    required this.bid,
    this.onTap,
    this.onBookmarkTap,
    this.onEditBidTap,
    this.onWithdrawTap,
    this.onViewContractTap,
  });

  Color _getStatusColor() {
    switch (bid.status) {
      case 'Pending Review':
        return const Color(0xFFFFB020);
      case 'Accepted':
        return const Color(0xFF00B368);
      case 'Rejected':
        return const Color(0xFFFF3B30);
      default:
        try {
          final hex = bid.statusColorHex.replaceAll('#', '');
          return Color(int.parse('FF$hex', radix: 16));
        } catch (_) {
          return const Color(0xFFFFB020);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header: Image + Badge + Title + Location + Bookmark
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image (~56x56)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  bid.image,
                  width: 56.w,
                  height: 56.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 56.w,
                    height: 56.h,
                    color: const Color(0xFFECEFF1),
                    child: Icon(
                      Icons.apartment_rounded,
                      color: AppColors.primary,
                      size: 28.r,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Title, Location, and Status Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Badge (Pill shape)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        bid.status,
                        style: TextStyle(
                          color: AppColors.white100,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Title
                    Text(
                      bid.title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black100,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),

                    // Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 14.r,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            bid.location,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF8E8E93),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bookmark Icon
              GestureDetector(
                onTap: onBookmarkTap,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(4.r),
                  child: Icon(
                    bid.isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: bid.isBookmarked
                        ? AppColors.primary
                        : const Color(0xFF8E8E93),
                    size: 22.r,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // 2. Stats Row (Your Bid | Duration | Submitted)
          Row(
            children: [
              // Your Bid (Spacious flex)
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Bid',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF8E8E93),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      bid.yourBid,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Wide spacer between Price and Duration
              SizedBox(width: 16.w),

              // Duration
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Duration',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF8E8E93),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      bid.duration,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12.w),

              // Submitted (Right-aligned)
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Submitted',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF8E8E93),
                      ),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      bid.submittedDate,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // 3. Dynamic Bottom Action Section
          _buildActionSection(context),
        ],
      ),
    ),
  ),
),
);
  }

  Widget _buildActionSection(BuildContext context) {
    if (bid.status == 'Pending Review') {
      return Row(
        children: [
          // Edit Bid Button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onEditBidTap,
              icon: Icon(
                Icons.edit_outlined,
                size: 16.r,
                color: AppColors.primary,
              ),
              label: Text(
                'Edit Bid',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: AppColors.primary,
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Withdraw Button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onWithdrawTap,
              icon: Icon(
                Icons.delete_outline_rounded,
                size: 16.r,
                color: const Color(0xFFFF3B30),
              ),
              label: Text(
                'Withdraw',
                style: TextStyle(
                  color: const Color(0xFFFF3B30),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFFFF3B30),
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          ),
        ],
      );
    } else if (bid.status == 'Accepted') {
      return SizedBox(
        width: double.infinity,
        height: 44.h,
        child: ElevatedButton(
          onPressed: onViewContractTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            'View Contract →',
            style: TextStyle(
              color: AppColors.white100,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      // Rejected Info Box
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F8FA),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: const Color(0xFFE5E5EA),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 16.r,
              color: const Color(0xFF8E8E93),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                bid.rejectionReason ??
                    'Not a suitable match for the current project requirements.',
                style: TextStyle(
                  color: const Color(0xFF8E8E93),
                  fontSize: 12.sp,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
