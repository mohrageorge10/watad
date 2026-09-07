import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/onboarding/presentation/data/mock/on_boarding_mock_data.dart';
import 'package:watad/features/onboarding/presentation/view/sections/on_boarding_content_section.dart';
import 'package:watad/features/onboarding/presentation/view/sections/on_boarding_header_section.dart';


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentIndex < OnBoardingMockData.items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() async {
    await CacheHelper().saveData(
      key: CacheKeys.hasSeenOnboarding,
      value: true,
    );
    if (mounted) context.go(AppRoutes.welcome);
  }
  @override
  Widget build(BuildContext context) {
    final currentItem = OnBoardingMockData.items[_currentIndex];
    final screenHeight = MediaQuery.of(context).size.height;
    const double contentHeightRatio = 0.382;
    final contentHeight = screenHeight * contentHeightRatio;

    return Scaffold(
      backgroundColor: AppColors.white100,
      body: Stack(
        children: [
          Positioned.fill(
            child: OnBoardingHeaderSection(
              pageController: _pageController,
              items: OnBoardingMockData.items,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: contentHeight,
            child: OnBoardingContentSection(
              item: currentItem,
              itemCount: OnBoardingMockData.items.length,
              currentIndex: _currentIndex,
              onNextPressed: _onNextPressed,
              onSkipPressed: _navigateToNextScreen,
            ),
          ),
        ],
      ),
    );
  }
}
