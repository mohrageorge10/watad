import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/domain/entities/auth_response_entity.dart';
import 'package:watad/features/auth/domain/entities/user_entity.dart';
import 'package:watad/features/auth/domain/usecases/auth_usecases.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/auth/presentation/cubit/auth_state.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockRegisterUseCase extends Mock implements RegisterUseCase {}
class MockConfirmEmailUseCase extends Mock implements ConfirmEmailUseCase {}
class MockResendOtpUseCase extends Mock implements ResendOtpUseCase {}
class MockForgotPasswordUseCase extends Mock implements ForgotPasswordUseCase {}
class MockVerifyOtpUseCase extends Mock implements VerifyOtpUseCase {}
class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}
class MockGoogleLoginUseCase extends Mock implements GoogleLoginUseCase {}
class MockFacebookLoginUseCase extends Mock implements FacebookLoginUseCase {}
class MockVerifyCurrentPasswordUseCase extends Mock implements VerifyCurrentPasswordUseCase {}
class MockConfirmNewPasswordUseCase extends Mock implements ConfirmNewPasswordUseCase {}
class MockCacheHelper extends Mock implements CacheHelper {}
class MockSecureStorageHelper extends Mock implements SecureStorageHelper {}

void main() {
  late AuthCubit authCubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockConfirmEmailUseCase mockConfirmEmailUseCase;
  late MockResendOtpUseCase mockResendOtpUseCase;
  late MockForgotPasswordUseCase mockForgotPasswordUseCase;
  late MockVerifyOtpUseCase mockVerifyOtpUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late MockGoogleLoginUseCase mockGoogleLoginUseCase;
  late MockFacebookLoginUseCase mockFacebookLoginUseCase;
  late MockVerifyCurrentPasswordUseCase mockVerifyCurrentPasswordUseCase;
  late MockConfirmNewPasswordUseCase mockConfirmNewPasswordUseCase;
  late MockCacheHelper mockCacheHelper;
  late MockSecureStorageHelper mockSecureStorageHelper;

  setUpAll(() {
    registerFallbackValue(
      const LoginRequestModel(email: 'test@watad.org', password: 'Password123'),
    );
    registerFallbackValue(
      const VerifyOtpRequestModel(email: 'test@watad.org', otp: '123456'),
    );
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockConfirmEmailUseCase = MockConfirmEmailUseCase();
    mockResendOtpUseCase = MockResendOtpUseCase();
    mockForgotPasswordUseCase = MockForgotPasswordUseCase();
    mockVerifyOtpUseCase = MockVerifyOtpUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    mockGoogleLoginUseCase = MockGoogleLoginUseCase();
    mockFacebookLoginUseCase = MockFacebookLoginUseCase();
    mockVerifyCurrentPasswordUseCase = MockVerifyCurrentPasswordUseCase();
    mockConfirmNewPasswordUseCase = MockConfirmNewPasswordUseCase();
    mockCacheHelper = MockCacheHelper();
    mockSecureStorageHelper = MockSecureStorageHelper();

    authCubit = AuthCubit(
      loginUseCase: mockLoginUseCase,
      registerUseCase: mockRegisterUseCase,
      confirmEmailUseCase: mockConfirmEmailUseCase,
      resendOtpUseCase: mockResendOtpUseCase,
      forgotPasswordUseCase: mockForgotPasswordUseCase,
      verifyOtpUseCase: mockVerifyOtpUseCase,
      resetPasswordUseCase: mockResetPasswordUseCase,
      googleLoginUseCase: mockGoogleLoginUseCase,
      facebookLoginUseCase: mockFacebookLoginUseCase,
      verifyCurrentPasswordUseCase: mockVerifyCurrentPasswordUseCase,
      confirmNewPasswordUseCase: mockConfirmNewPasswordUseCase,
      cacheHelper: mockCacheHelper,
      secureStorage: mockSecureStorageHelper,
    );
  });

  tearDown(() {
    authCubit.close();
  });

  group('AuthCubit Tests', () {
    test('initial state is AuthInitial', () {
      expect(authCubit.state, isA<AuthInitial>());
    });

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, LoginSuccessState] on successful login with rememberMe',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer(
          (_) async => ApiResult.success(
            const AuthResponseEntity(
              isSuccess: true,
              statusCode: 200,
              message: 'Login successful',
              user: UserEntity(
                token: 'sample_token_xyz',
                expirationDate: '2026-10-01T00:00:00Z',
              ),
            ),
          ),
        );
        when(() => mockSecureStorageHelper.write(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async {});
        when(() => mockCacheHelper.saveData(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => true);

        return authCubit;
      },
      act: (cubit) => cubit.login(
        const LoginRequestModel(
          email: 'test@watad.org',
          password: 'Password123',
          rememberMe: true,
        ),
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<LoginSuccessState>().having(
          (s) => s.response.message,
          'message',
          'Login successful',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthErrorState] on login failure',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer(
          (_) async => ApiResult.failure(
            const ServerFailure(errMessage: 'Invalid credentials'),
          ),
        );
        return authCubit;
      },
      act: (cubit) => cubit.login(
        const LoginRequestModel(
          email: 'wrong@watad.org',
          password: 'WrongPassword',
        ),
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthErrorState>().having(
          (s) => s.message,
          'message',
          'Invalid credentials',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, VerifyOtpSuccessState] with extracted resetToken on successful verifyOtp',
      build: () {
        when(() => mockVerifyOtpUseCase(any())).thenAnswer(
          (_) async => ApiResult.success(
            const AuthResponseEntity(
              isSuccess: true,
              statusCode: 200,
              message: 'OTP verified successfully.',
              user: UserEntity(
                token: '50c4322b-b6c3-4d87-91f2-16dc04f0584d',
              ),
            ),
          ),
        );
        return authCubit;
      },
      act: (cubit) => cubit.verifyOtp(
        const VerifyOtpRequestModel(
          email: 'test@watad.org',
          otp: '682064',
        ),
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<VerifyOtpSuccessState>()
            .having(
              (s) => s.resetToken,
              'resetToken',
              '50c4322b-b6c3-4d87-91f2-16dc04f0584d',
            )
            .having(
              (s) => s.message,
              'message',
              'OTP verified successfully.',
            ),
      ],
    );
  });
}
