import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/constants/app_images.dart';

class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesLogo,
      width: 200.w,
      height: 200.h,
      fit: BoxFit.contain,
    );
  }
}
