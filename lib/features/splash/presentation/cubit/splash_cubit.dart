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
    final bool hasSeenOnboarding =
        cacheHelper.getData(key: CacheKeys.hasSeenOnboarding) ?? false;

    if (!hasSeenOnboarding) {
      emit(SplashNavigate(AppRoutes.onBoarding));
      return;
    }

    final bool isLoggedIn = await cacheHelper.containsKey(key: CacheKeys.token);

    emit(SplashNavigate(isLoggedIn ? AppRoutes.home : AppRoutes.welcome));
  }
}
