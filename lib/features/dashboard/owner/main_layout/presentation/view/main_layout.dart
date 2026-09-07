import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/dashboard/owner/home/presentation/view/home_view.dart';
import '../cubit/main_layout_cubit.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainLayoutCubit(),
      child: BlocBuilder<MainLayoutCubit, MainLayoutState>(
        builder: (context, state) {
          final cubit = context.read<MainLayoutCubit>();
          
          return Scaffold(
            backgroundColor: AppColors.background,
            body: IndexedStack(
              index: cubit.currentIndex,
              children: [
                const HomeView(), // 1. Home
                const Center(child: Text("Dashboard")), // 2. Dashboard
                const Center(child: Text("Marketplace")), // 3. Marketplace
                const Center(child: Text("Alerts")), // 4. Alerts
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      sl<AuthCubit>().logout();
                      context.go(AppRoutes.welcome);
                    },
                    child: const Text('Logout'),
                  ),
                ), // 5. Profile
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: cubit.changeBottomNavIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.deactivation,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined),
                    activeIcon: Icon(Icons.dashboard_rounded),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.storefront_outlined),
                    activeIcon: Icon(Icons.storefront_rounded),
                    label: 'Market',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none_outlined),
                    activeIcon: Icon(Icons.notifications_rounded),
                    label: 'Alerts',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_rounded),
                    activeIcon: Icon(Icons.person_rounded),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
