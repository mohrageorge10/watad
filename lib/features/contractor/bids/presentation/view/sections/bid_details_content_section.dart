import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/bids/presentation/view/widgets/bid_attachment_tile_widget.dart';
import 'package:watad/features/contractor/bids/presentation/view/widgets/bid_key_detail_item_widget.dart';
import 'package:watad/features/contractor/bids/presentation/view/widgets/bid_spec_column_widget.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/marketplace_image_gallery.dart';

class BidDetailsContentSection extends StatefulWidget {
  final String title;
  final String location;
  final String status;
  final String estimatedBudget;
  final String expectedDuration;
  final String startDate;
  final String completionDate;
  final String landArea;
  final String floors;
  final String finishingLevel;
  final String description;
  final List<String> images;
  final bool initialIsBookmarked;

  const BidDetailsContentSection({
    super.key,
    this.title = 'Villa Construction Project',
    this.location = 'New Cairo, Cairo',
    this.status = 'Pending Review',
    this.estimatedBudget = 'EGP 2,450,000',
    this.expectedDuration = '6 Months',
    this.startDate = 'Nov 2026',
    this.completionDate = 'May 2027',
    this.landArea = '500 m²',
    this.floors = '2',
    this.finishingLevel = 'Standard',
    this.description =
        'A modern villa with contemporary design, integrated smart home systems, and premium finishing. Located in a prime area in New Cairo.',
    this.images = const [
      'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80',
      'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400&q=80',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=80',
      'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=400&q=80',
      'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400&q=80',
      'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=400&q=80',
      'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=400&q=80',
    ],
    this.initialIsBookmarked = false,
  });

  @override
  State<BidDetailsContentSection> createState() =>
      _BidDetailsContentSectionState();
}

class _BidDetailsContentSectionState extends State<BidDetailsContentSection> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.initialIsBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Image Gallery with Main Hero & 4 Thumbnails
          MarketplaceImageGallery(
            images: widget.images,
          ),

          SizedBox(height: 16.h),

          // 2. Status Badge (Right-aligned, white bg, yellow text and border)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.white100,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: const Color(0xFFFFB020),
                  width: 1.5,
                ),
              ),
              child: Text(
                widget.status,
                style: TextStyle(
                  color: const Color(0xFFFFB020),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // 3. Core Details Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Header Row: Building icon, Title + Location, Bookmark icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.apartment_rounded,
                      color: AppColors.primary,
                      size: 24.r,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1D1D1F),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: const Color(0xFF8E8E93),
                                size: 14.r,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                widget.location,
                                style: TextStyle(
                                  color: const Color(0xFF1D1D1F),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isBookmarked = !_isBookmarked;
                        });
                      },
                      icon: Icon(
                        _isBookmarked
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_outline_rounded,
                        color: AppColors.primary,
                        size: 24.r,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Specs Section (Row with spaceEvenly)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BidSpecColumnWidget(
                      icon: Icons.aspect_ratio_rounded,
                      label: 'Land Area',
                      value: widget.landArea,
                    ),
                    BidSpecColumnWidget(
                      icon: Icons.layers_outlined,
                      label: 'Floors',
                      value: widget.floors,
                    ),
                    BidSpecColumnWidget(
                      icon: Icons.check_circle_outline_rounded,
                      label: 'Finishing Level',
                      value: widget.finishingLevel,
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Key Details Grid (2x2)
                Row(
                  children: [
                    Expanded(
                      child: BidKeyDetailItemWidget(
                        label: 'Estimated Budget',
                        value: widget.estimatedBudget,
                        valueColor: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: BidKeyDetailItemWidget(
                        label: 'Expected Duration',
                        value: widget.expectedDuration,
                        valueColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                Row(
                  children: [
                    Expanded(
                      child: BidKeyDetailItemWidget(
                        label: 'Start Date',
                        value: widget.startDate,
                        icon: Icons.calendar_today_outlined,
                        valueColor: const Color(0xFF1D1D1F),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: BidKeyDetailItemWidget(
                        label: 'Completion Date',
                        value: widget.completionDate,
                        icon: Icons.access_time_rounded,
                        valueColor: const Color(0xFF1D1D1F),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Description Section
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1D1D1F),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: const Color(0xFF8E8E93),
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 24.h),

                // Attachments Section
                Text(
                  'Attachments',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1D1D1F),
                  ),
                ),
                SizedBox(height: 10.h),

                const BidAttachmentTileWidget(
                  title: 'Architectural_Drawings.pdf',
                  size: '4.2 MB',
                ),
                const BidAttachmentTileWidget(
                  title: 'Soil_Survey_Report.pdf',
                  size: '1.8 MB',
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
