import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/constants/app_images.dart';

class OnBoardingBrandLogoWidget extends StatelessWidget {
  const OnBoardingBrandLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesLogo,
      width: 67.w,
      height: 67.h,
      fit: BoxFit.contain,
    );
  }
}
