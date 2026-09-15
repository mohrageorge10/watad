import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class SourcesBadgeWidget extends StatefulWidget {
  const SourcesBadgeWidget({Key? key}) : super(key: key);

  @override
  State<SourcesBadgeWidget> createState() => _SourcesBadgeWidgetState();
}

class _SourcesBadgeWidgetState extends State<SourcesBadgeWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.grey200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                Icon(Icons.attach_file, size: 14.w, color: AppColors.primary),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text(
                    'Sources: Contract_v2.pdf, BoQ_Excavation.xlsx',
                    style: AppTextStyles.font12RegularGrey.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: _isExpanded ? null : 1,
                    overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 16.w,
                  color: AppColors.grey500,
                ),
              ],
            ),
            if (_isExpanded) ...[
              SizedBox(height: 8.h),
              Text(
                '- Contract_v2.pdf (Item 4.2)\n- BoQ_Excavation.xlsx (Page 3)',
                style: AppTextStyles.font12RegularGrey.copyWith(
                  height: 1.5,
                  color: AppColors.black100,
                ),
                textDirection: TextDirection.rtl,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
