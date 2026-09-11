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

    // 1. Check if user has seen Onboarding
    final bool hasSeenOnboarding =
        cacheHelper.getData(key: CacheKeys.hasSeenOnboarding) ?? false;

    if (!hasSeenOnboarding) {
      emit(SplashNavigate(AppRoutes.onBoarding));
      return;
    }

    // 2. Check Remember Me: if user chose not to stay logged in, clear session
    final bool rememberMe =
        cacheHelper.getData(key: CacheKeys.rememberMe) ?? true;
    if (!rememberMe) {
      TokenManager.instance.clearToken();
      await secureStorage.delete(key: CacheKeys.token);
      await cacheHelper.removeData(key: CacheKeys.token);
      emit(SplashNavigate(AppRoutes.welcome));
      return;
    }

    // 3. Load token from memory or secure storage
    String? token = TokenManager.instance.token;
    if (token == null || token.isEmpty) {
      token = await secureStorage.read(key: CacheKeys.token) ??
          (cacheHelper.getData(key: CacheKeys.token) as String?);
      if (token != null && token.isNotEmpty) {
        TokenManager.instance.setToken(token);
      }
    }

    if (token == null || token.isEmpty) {
      emit(SplashNavigate(AppRoutes.welcome));
      return;
    }

    // 4. Check expiration date if available
    final String? expirationStr =
        cacheHelper.getData(key: CacheKeys.tokenExpiration);

    if (expirationStr != null && expirationStr.isNotEmpty) {
      final DateTime? expiration = DateTime.tryParse(expirationStr);
      if (expiration != null && DateTime.now().isAfter(expiration)) {
        // Token has expired -> thoroughly clean all token storages
        TokenManager.instance.clearToken();
        await secureStorage.delete(key: CacheKeys.token);
        await cacheHelper.removeData(key: CacheKeys.token);
        await cacheHelper.removeData(key: CacheKeys.tokenExpiration);
        emit(SplashNavigate(AppRoutes.welcome));
        return;
      }
    }

    // Token is valid and unexpired -> navigate to HomeGateScreen to route by role
    emit(SplashNavigate(AppRoutes.home));
  }
}
