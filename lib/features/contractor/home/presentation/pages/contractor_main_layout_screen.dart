import 'package:flutter/material.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/home/presentation/pages/contractor_home_page.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_bottom_nav_bar.dart';
import 'package:watad/features/contractor/bids/presentation/pages/contractor_bids_screen.dart';
import 'package:watad/features/contractor/portfolio/presentation/pages/portfolio_projects_screen.dart';
import 'package:watad/features/contractor/profile/presentation/pages/contractor_profile_page.dart';
import 'package:watad/features/contractor/marketplace/presentation/pages/marketplace_screen.dart';

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
            onNavigateToBids: () => _onTabTapped(3),
            onNavigateToProfile: () => _onTabTapped(4),
          ),

          // Tab 1: Marketplace Screen
          MarketplaceScreen(
            showBottomNavBar: false,
            onBackTap: () => _onTabTapped(0),
          ),

          // Tab 2: My Projects (Portfolio Projects Screen)
          PortfolioProjectsScreen(
            showBottomNavBar: false,
            onBackTap: () => _onTabTapped(0),
          ),

          // Tab 3: My Bids (Contractor Bids with infinite scroll)
          const ContractorBidsScreen(
            showBackButton: false,
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
