import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/site_update_photo.dart';
import 'site_update_photo_card.dart';

class SiteUpdatesGrid extends StatelessWidget {
  final List<SiteUpdatePhoto> photos;

  const SiteUpdatesGrid({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: photos.take(3).map((photo) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: SizedBox(
              height: 120.h,
              child: SiteUpdatePhotoCard(photo: photo),
            ),
          ),
        );
      }).toList(),
    );
  }
}
