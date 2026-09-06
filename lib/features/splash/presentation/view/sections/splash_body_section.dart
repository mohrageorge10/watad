import 'package:flutter/material.dart';
import 'package:watad/features/splash/presentation/view/widgets/splash_logo_widget.dart';

class SplashBodySection extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;

  const SplashBodySection({
    super.key,
    required this.fadeAnimation,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: const SplashLogoWidget(),
        ),
      ),
    );
  }
}
