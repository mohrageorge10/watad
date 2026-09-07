import 'package:flutter/material.dart';


class OnBoardingImageWidget extends StatelessWidget {
  final String imagePath;
  const OnBoardingImageWidget({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }
}