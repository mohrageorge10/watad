import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CacheHelper cacheHelper;
  SplashCubit({CacheHelper? cacheHelper})
      : cacheHelper = cacheHelper ?? CacheHelper(),
        super(SplashInitial());

  Future<void> decideNextRoute() async {
    emit(SplashLoading());

    // 1. Check if user has seen Onboarding
    final bool hasSeenOnboarding =
        cacheHelper.getData(key: CacheKeys.hasSeenOnboarding) ?? false;

    if (!hasSeenOnboarding) {
      emit(SplashNavigate(AppRoutes.onBoarding));
      return;
    }

    // 2. Check if token is stored
    final String? token = cacheHelper.getData(key: CacheKeys.token);

    if (token == null || token.isEmpty) {
      emit(SplashNavigate(AppRoutes.welcome));
      return;
    }

    // 3. Check expiration date if available
    final String? expirationStr =
        cacheHelper.getData(key: CacheKeys.tokenExpiration);

    if (expirationStr != null && expirationStr.isNotEmpty) {
      final DateTime? expiration = DateTime.tryParse(expirationStr);
      if (expiration != null && DateTime.now().isAfter(expiration)) {
        // Token has expired -> clear stored token and send to welcome
        await cacheHelper.removeData(key: CacheKeys.token);
        emit(SplashNavigate(AppRoutes.welcome));
        return;
      }
    }

    // Token is valid and unexpired
    emit(SplashNavigate(AppRoutes.home));
  }
}
