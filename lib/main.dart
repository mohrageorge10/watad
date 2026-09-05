import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_router.dart';
import 'package:watad/core/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await setupServiceLocator();

  runApp(const WatadApp());
}

class WatadApp extends StatelessWidget {
  const WatadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Watad',
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Inter',
            scaffoldBackgroundColor: AppColors.white100,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary700,
              primary: AppColors.primary700,
            ),
          ),
        );
      },
    );
  }
}
