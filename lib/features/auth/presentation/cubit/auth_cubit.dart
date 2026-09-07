import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/domain/entities/user_entity.dart';
import 'package:watad/features/auth/domain/usecases/auth_usecases.dart';
import 'package:watad/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ConfirmEmailUseCase confirmEmailUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final GoogleLoginUseCase googleLoginUseCase;
  final FacebookLoginUseCase facebookLoginUseCase;
  final CacheHelper cacheHelper;
  final SecureStorageHelper secureStorage;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.confirmEmailUseCase,
    required this.resendOtpUseCase,
    required this.forgotPasswordUseCase,
    required this.verifyOtpUseCase,
    required this.resetPasswordUseCase,
    required this.googleLoginUseCase,
    required this.facebookLoginUseCase,
    required this.cacheHelper,
    required this.secureStorage,
  }) : super(AuthInitial());

  Future<void> login(LoginRequestModel request) async {
    emit(AuthLoading());
    final result = await loginUseCase(request);
    result.fold(
      (response) async {
        if (response.user != null) {
          await _saveUserSession(
            user: response.user!,
            rememberMe: request.rememberMe,
          );
        }
        emit(LoginSuccessState(response));
      },
      (failure) {
        emit(AuthErrorState(failure.errMessage));
      },
    );
  }

  Future<void> register(RegisterRequestModel request) async {
    emit(AuthLoading());
    final result = await registerUseCase(request);
    result.fold(
      (response) {
        emit(RegisterSuccessState(response));
      },
      (failure) {
        emit(AuthErrorState(failure.errMessage));
      },
    );
  }

  Future<void> confirmEmail(ConfirmEmailRequestModel request) async {
    emit(AuthLoading());
    final result = await confirmEmailUseCase(request);
    result.fold(
      (response) async {
        if (response.user != null) {
          // After registration email confirmation, automatically save session
          await _saveUserSession(
            user: response.user!,
            rememberMe: true,
          );
        }
        emit(ConfirmEmailSuccessState(response));
      },
      (failure) {
        emit(AuthErrorState(failure.errMessage));
      },
    );
  }

  Future<void> resendOtp(String email) async {
    final result = await resendOtpUseCase(email);
    result.fold(
      (response) {
        emit(ResendOtpSuccessState(response.message));
      },
      (failure) {
        emit(AuthErrorState(failure.errMessage));
      },
    );
  }

  Future<void> forgotPassword(ForgotPasswordRequestModel request) async {
    emit(AuthLoading());
    final result = await forgotPasswordUseCase(request);
    result.fold(
      (response) {
        emit(ForgotPasswordSuccessState(response.message));
      },
      (failure) {
        emit(AuthErrorState(failure.errMessage));
      },
    );
  }

  Future<void> verifyOtp(VerifyOtpRequestModel request) async {
    emit(AuthLoading());
    final result = await verifyOtpUseCase(request);
    result.fold(
      (response) {
        // extract reset token from response message or data
        final resetToken = response.user?.token ?? request.otp;
        emit(VerifyOtpSuccessState(
          resetToken: resetToken,
          message: response.message,
        ));
      },
      (failure) {
        emit(AuthErrorState(failure.errMessage));
      },
    );
  }

  Future<void> resetPassword(ResetPasswordRequestModel request) async {
    emit(AuthLoading());
    final result = await resetPasswordUseCase(request);
    result.fold(
      (response) {
        emit(ResetPasswordSuccessState(response.message));
      },
      (failure) {
        emit(AuthErrorState(failure.errMessage));
      },
    );
  }

  Future<void> googleLogin(GoogleLoginRequestModel request) async {
    emit(AuthLoading());
    final result = await googleLoginUseCase(request);
    result.fold(
      (response) async {
        if (response.user != null) {
          await _saveUserSession(
            user: response.user!,
            rememberMe: true,
          );
        }
        emit(SocialLoginSuccessState(response));
      },
      (failure) {
        emit(AuthErrorState(failure.errMessage));
      },
    );
  }

  Future<void> facebookLogin(FacebookLoginRequestModel request) async {
    emit(AuthLoading());
    final result = await facebookLoginUseCase(request);
    result.fold(
      (response) async {
        if (response.user != null) {
          await _saveUserSession(
            user: response.user!,
            rememberMe: true,
          );
        }
        emit(SocialLoginSuccessState(response));
      },
      (failure) {
        emit(AuthErrorState(failure.errMessage));
      },
    );
  }

  Future<void> _saveUserSession({
    required UserEntity user,
    required bool rememberMe,
  }) async {
    // 1. Always store in SecureStorage for immediate active bearer tokens
    if (user.token != null && user.token!.isNotEmpty) {
      await secureStorage.write(key: CacheKeys.token, value: user.token!);
      if (rememberMe) {
        await cacheHelper.saveData(key: CacheKeys.token, value: user.token!);
      } else {
        await cacheHelper.removeData(key: CacheKeys.token);
      }
    }

    if (user.refreshToken != null && user.refreshToken!.isNotEmpty) {
      await secureStorage.write(
        key: CacheKeys.refreshToken,
        value: user.refreshToken!,
      );
      if (rememberMe) {
        await cacheHelper.saveData(
          key: CacheKeys.refreshToken,
          value: user.refreshToken!,
        );
      }
    }

    if (user.expirationDate != null && user.expirationDate!.isNotEmpty) {
      await cacheHelper.saveData(
        key: CacheKeys.tokenExpiration,
        value: user.expirationDate!,
      );
    }

    if (user.userId != null) {
      await cacheHelper.saveData(key: CacheKeys.userId, value: user.userId!);
    }
    if (user.role != null) {
      await cacheHelper.saveData(key: CacheKeys.userRole, value: user.role!);
    }
    if (user.userType != null) {
      await cacheHelper.saveData(key: CacheKeys.userType, value: user.userType!);
    }
    if (user.fullName != null) {
      await cacheHelper.saveData(key: CacheKeys.userName, value: user.fullName!);
    }
  }
}
