import 'package:flutter/material.dart';
import 'package:watad/features/onboarding/data/models/on_boarding_model.dart';
import 'package:watad/features/onboarding/presentation/view/widgets/on_boarding_image_widget.dart';

class OnBoardingHeaderSection extends StatelessWidget {
  final PageController pageController;
  final List<OnBoardingModel> items;
  final ValueChanged<int> onPageChanged;

  const OnBoardingHeaderSection({
    super.key,
    required this.pageController,
    required this.items,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return OnBoardingImageWidget(
          imagePath: items[index].imagePath,
        );
      },
    );
  }
}
