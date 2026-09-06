import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:watad/features/splash/presentation/cubit/splash_state.dart';
import 'package:watad/features/splash/presentation/view/sections/splash_body_section.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late SplashCubit _splashCubit;
  @override
  void initState() {
    super.initState();
    _splashCubit = SplashCubit();
    _initAnimation();
    _startTimer();
  }

  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        _splashCubit.decideNextRoute();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _splashCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _splashCubit,
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigate) {
            context.go(state.route);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white100,
          body: SplashBodySection(
            fadeAnimation: _fadeAnimation,
            scaleAnimation: _scaleAnimation,
          ),
        ),
      ),
    );
  }
}
