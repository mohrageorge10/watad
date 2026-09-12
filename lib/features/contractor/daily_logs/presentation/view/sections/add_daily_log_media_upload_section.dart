import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/daily_logs/presentation/view/widgets/media_upload_dropzone_widget.dart';
import 'package:watad/features/contractor/daily_logs/presentation/view/widgets/uploaded_photo_item_widget.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/view/widgets/dashed_add_log_button_widget.dart';

class AddDailyLogMediaUploadSection extends StatelessWidget {
  final List<String> mediaList;
  final VoidCallback? onDropzoneTap;
  final VoidCallback? onAddMoreTap;
  final ValueChanged<int>? onDeletePhoto;

  const AddDailyLogMediaUploadSection({
    super.key,
    required this.mediaList,
    this.onDropzoneTap,
    this.onAddMoreTap,
    this.onDeletePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          'Media Upload',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1D1D1F),
          ),
        ),

        SizedBox(height: 12.h),

        // Dropzone Card
        MediaUploadDropzoneWidget(
          onTap: onDropzoneTap,
        ),

        SizedBox(height: 14.h),

        // Horizontal list of uploaded items + Add Button
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              ...List.generate(mediaList.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: UploadedPhotoItemWidget(
                    path: mediaList[index],
                    onDelete: onDeletePhoto != null
                        ? () => onDeletePhoto!(index)
                        : null,
                  ),
                );
              }),

              // Dashed Add Button
              DashedAddLogButtonWidget(
                onTap: onAddMoreTap ?? onDropzoneTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
