import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/entities/milestone_inspection_details_entity.dart';
import 'package:watad/features/contractor/milestone_inspection/presentation/view/widgets/inspection_photo_details_dialog.dart';
import 'package:watad/features/contractor/milestone_inspection/presentation/view/widgets/milestone_gallery_card_widget.dart';

class MilestoneInspectionGallerySection extends StatefulWidget {
  final List<InspectionGalleryItemEntity> galleryItems;
  final VoidCallback? onViewAllTap;
  final ValueChanged<InspectionGalleryItemEntity>? onGalleryItemTap;

  const MilestoneInspectionGallerySection({
    super.key,
    required this.galleryItems,
    this.onViewAllTap,
    this.onGalleryItemTap,
  });

  @override
  State<MilestoneInspectionGallerySection> createState() =>
      _MilestoneInspectionGallerySectionState();
}

class _MilestoneInspectionGallerySectionState
    extends State<MilestoneInspectionGallerySection> {
  bool _isExpanded = false;

  void _handlePhotoTap(InspectionGalleryItemEntity item) {
    if (widget.onGalleryItemTap != null) {
      widget.onGalleryItemTap!(item);
    } else {
      InspectionPhotoDetailsDialog.show(context, item: item);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalCount = widget.galleryItems.length;
    final displayedItems = _isExpanded
        ? widget.galleryItems
        : widget.galleryItems.take(6).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header with Title & Expand/View All Toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Site Logs Gallery ($totalCount)',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1D1D1F),
              ),
            ),
            if (totalCount > 6)
              InkWell(
                onTap: () {
                  if (widget.onViewAllTap != null) {
                    widget.onViewAllTap!();
                  }
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                borderRadius: BorderRadius.circular(6.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isExpanded ? 'Show Less' : 'View All',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E3A8A),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 16.r,
                        color: const Color(0xFF1E3A8A),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),

        SizedBox(height: 12.h),

        // 2. 3-column Grid
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayedItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) {
              final item = displayedItems[index];
              return MilestoneGalleryCardWidget(
                item: item,
                onTap: () => _handlePhotoTap(item),
              );
            },
          ),
        ),
      ],
    );
  }
}
