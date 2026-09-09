import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/cache/token_manager.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CacheHelper cacheHelper;
  final SecureStorageHelper secureStorage;

  SplashCubit({
    CacheHelper? cacheHelper,
    SecureStorageHelper? secureStorage,
  })  : cacheHelper = cacheHelper ?? CacheHelper(),
        secureStorage = secureStorage ?? SecureStorageHelper(),
        super(SplashInitial());

  Future<void> decideNextRoute() async {
    emit(SplashLoading());

    // 0. Load token from SecureStorage into TokenManager (for cold starts)
    final String? savedToken = await secureStorage.read(key: CacheKeys.token);
    if (savedToken != null && savedToken.isNotEmpty) {
      TokenManager.instance.setToken(savedToken);
    }

    // 1. Check if user has seen Onboarding
    final bool hasSeenOnboarding =
        cacheHelper.getData(key: CacheKeys.hasSeenOnboarding) ?? false;

    if (!hasSeenOnboarding) {
      emit(SplashNavigate(AppRoutes.onBoarding));
      return;
    }

    // 2. Check if token is stored (check memory first, then SharedPrefs)
    final String? token = TokenManager.instance.token ?? cacheHelper.getData(key: CacheKeys.token);

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
    emit(SplashNavigate(AppRoutes.projectDashboard));
  }
}
