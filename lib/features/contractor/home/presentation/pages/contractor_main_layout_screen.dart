import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/home/presentation/pages/contractor_home_page.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_bottom_nav_bar.dart';
import 'package:watad/features/contractor/portfolio/presentation/pages/portfolio_projects_screen.dart';
import 'package:watad/features/contractor/profile/presentation/pages/contractor_profile_page.dart';

class ContractorMainLayoutScreen extends StatefulWidget {
  const ContractorMainLayoutScreen({super.key});

  @override
  State<ContractorMainLayoutScreen> createState() =>
      _ContractorMainLayoutScreenState();
}

class _ContractorMainLayoutScreenState
    extends State<ContractorMainLayoutScreen> {
  int _currentIndex = 0;
  final bool _hasNewAlerts = false; // Controls the red badge on Alerts tab
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.signUp,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Tab 0: Home (Dynamic Data-driven Home Screen)
          ContractorHomePage(
            onNavigateToMarketplace: () => _onTabTapped(1),
            onNavigateToProfile: () => _onTabTapped(4),
          ),

          // Tab 1: Marketplace Placeholder
          const _PlaceholderTabScreen(
            title: 'Marketplace',
            icon: Icons.grid_view_rounded,
          ),

          // Tab 2: My Projects (Portfolio Projects Screen)
          PortfolioProjectsScreen(
            showBottomNavBar: false,
            onBackTap: () => _onTabTapped(0),
          ),

          // Tab 3: My Bids Placeholder
          const _PlaceholderTabScreen(
            title: 'My Bids',
            icon: Icons.article_outlined,
          ),

          // Tab 4: Profile
          ContractorProfilePage(
            showBottomNavBar: false,
            onNavigateToMyProjects: () => _onTabTapped(2),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: ContractorBottomNavBar(
          currentIndex: _currentIndex,
          hasNewAlerts: _hasNewAlerts,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}

class _PlaceholderTabScreen extends StatelessWidget {
  const _PlaceholderTabScreen({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48.r,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1D1D1F),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF8E8E93),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
