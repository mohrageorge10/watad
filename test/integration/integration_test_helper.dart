import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/domain/usecases/auth_usecases.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockRegisterUseCase extends Mock implements RegisterUseCase {}
class MockConfirmEmailUseCase extends Mock implements ConfirmEmailUseCase {}
class MockResendOtpUseCase extends Mock implements ResendOtpUseCase {}
class MockForgotPasswordUseCase extends Mock implements ForgotPasswordUseCase {}
class MockVerifyOtpUseCase extends Mock implements VerifyOtpUseCase {}
class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}
class MockGoogleLoginUseCase extends Mock implements GoogleLoginUseCase {}
class MockFacebookLoginUseCase extends Mock implements FacebookLoginUseCase {}
class MockCacheHelper extends Mock implements CacheHelper {}
class MockSecureStorageHelper extends Mock implements SecureStorageHelper {}

class TestDependencies {
  final MockLoginUseCase loginUseCase = MockLoginUseCase();
  final MockRegisterUseCase registerUseCase = MockRegisterUseCase();
  final MockConfirmEmailUseCase confirmEmailUseCase = MockConfirmEmailUseCase();
  final MockResendOtpUseCase resendOtpUseCase = MockResendOtpUseCase();
  final MockForgotPasswordUseCase forgotPasswordUseCase = MockForgotPasswordUseCase();
  final MockVerifyOtpUseCase verifyOtpUseCase = MockVerifyOtpUseCase();
  final MockResetPasswordUseCase resetPasswordUseCase = MockResetPasswordUseCase();
  final MockGoogleLoginUseCase googleLoginUseCase = MockGoogleLoginUseCase();
  final MockFacebookLoginUseCase facebookLoginUseCase = MockFacebookLoginUseCase();
  final MockCacheHelper cacheHelper = MockCacheHelper();
  final MockSecureStorageHelper secureStorage = MockSecureStorageHelper();
}

TestDependencies setupTestServiceLocator() {
  sl.reset();

  final deps = TestDependencies();

  // Register fallback values for mocktail
  registerFallbackValue(
    const LoginRequestModel(email: 'test@watad.org', password: 'Password123'),
  );
  registerFallbackValue(
    const RegisterRequestModel(
      fullName: 'Test User',
      email: 'test@watad.org',
      phoneNumber: '01012345678',
      password: 'Password123',
      confirmPassword: 'Password123',
      userType: 1,
    ),
  );
  registerFallbackValue(
    const ConfirmEmailRequestModel(email: 'test@watad.org', otp: '123456'),
  );
  registerFallbackValue(
    const ForgotPasswordRequestModel(email: 'test@watad.org'),
  );
  registerFallbackValue(
    const VerifyOtpRequestModel(email: 'test@watad.org', otp: '123456'),
  );
  registerFallbackValue(
    const ResetPasswordRequestModel(
      email: 'test@watad.org',
      resetToken: 'token123',
      newPassword: 'NewPassword123',
    ),
  );

  // Setup default mock behaviors
  when(() => deps.cacheHelper.saveData(key: any(named: 'key'), value: any(named: 'value')))
      .thenAnswer((_) async => true);
  when(() => deps.cacheHelper.removeData(key: any(named: 'key')))
      .thenAnswer((_) async => true);
  when(() => deps.secureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
      .thenAnswer((_) async => {});
  when(() => deps.secureStorage.delete(key: any(named: 'key')))
      .thenAnswer((_) async => {});

  // Register into GetIt
  sl.registerLazySingleton<LoginUseCase>(() => deps.loginUseCase);
  sl.registerLazySingleton<RegisterUseCase>(() => deps.registerUseCase);
  sl.registerLazySingleton<ConfirmEmailUseCase>(() => deps.confirmEmailUseCase);
  sl.registerLazySingleton<ResendOtpUseCase>(() => deps.resendOtpUseCase);
  sl.registerLazySingleton<ForgotPasswordUseCase>(() => deps.forgotPasswordUseCase);
  sl.registerLazySingleton<VerifyOtpUseCase>(() => deps.verifyOtpUseCase);
  sl.registerLazySingleton<ResetPasswordUseCase>(() => deps.resetPasswordUseCase);
  sl.registerLazySingleton<GoogleLoginUseCase>(() => deps.googleLoginUseCase);
  sl.registerLazySingleton<FacebookLoginUseCase>(() => deps.facebookLoginUseCase);
  sl.registerLazySingleton<CacheHelper>(() => deps.cacheHelper);
  sl.registerLazySingleton<SecureStorageHelper>(() => deps.secureStorage);

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: deps.loginUseCase,
      registerUseCase: deps.registerUseCase,
      confirmEmailUseCase: deps.confirmEmailUseCase,
      resendOtpUseCase: deps.resendOtpUseCase,
      forgotPasswordUseCase: deps.forgotPasswordUseCase,
      verifyOtpUseCase: deps.verifyOtpUseCase,
      resetPasswordUseCase: deps.resetPasswordUseCase,
      googleLoginUseCase: deps.googleLoginUseCase,
      facebookLoginUseCase: deps.facebookLoginUseCase,
      cacheHelper: deps.cacheHelper,
      secureStorage: deps.secureStorage,
    ),
  );

  return deps;
}

void setTestViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(600, 1000);
  tester.view.devicePixelRatio = 1.0;
}

Widget buildTestableApp({
  required GoRouter router,
}) {
  return ScreenUtilInit(
    designSize: const Size(600, 1000),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp.router(
        title: 'Watad Test',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        builder: FlutterSmartDialog.init(),
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
