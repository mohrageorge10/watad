import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/domain/entities/auth_response_entity.dart';
import 'package:watad/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  const LoginUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(LoginRequestModel request) =>
      repository.login(request);
}

class RegisterUseCase {
  final AuthRepository repository;
  const RegisterUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(RegisterRequestModel request) =>
      repository.register(request);
}

class ConfirmEmailUseCase {
  final AuthRepository repository;
  const ConfirmEmailUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(ConfirmEmailRequestModel request) =>
      repository.confirmEmail(request);
}

class ResendOtpUseCase {
  final AuthRepository repository;
  const ResendOtpUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(String email) =>
      repository.resendConfirmOtp(email);
}

class ForgotPasswordUseCase {
  final AuthRepository repository;
  const ForgotPasswordUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(ForgotPasswordRequestModel request) =>
      repository.forgotPassword(request);
}

class VerifyOtpUseCase {
  final AuthRepository repository;
  const VerifyOtpUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(VerifyOtpRequestModel request) =>
      repository.verifyOtp(request);
}

class ResetPasswordUseCase {
  final AuthRepository repository;
  const ResetPasswordUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(ResetPasswordRequestModel request) =>
      repository.resetPassword(request);
}

class GoogleLoginUseCase {
  final AuthRepository repository;
  const GoogleLoginUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(GoogleLoginRequestModel request) =>
      repository.googleLogin(request);
}

class FacebookLoginUseCase {
  final AuthRepository repository;
  const FacebookLoginUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(FacebookLoginRequestModel request) =>
      repository.facebookLogin(request);
}

class VerifyCurrentPasswordUseCase {
  final AuthRepository repository;
  const VerifyCurrentPasswordUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(VerifyCurrentPasswordRequestModel request) =>
      repository.verifyCurrentPassword(request);
}

class ConfirmNewPasswordUseCase {
  final AuthRepository repository;
  const ConfirmNewPasswordUseCase(this.repository);
  Future<ApiResult<AuthResponseEntity>> call(ConfirmNewPasswordRequestModel request) =>
      repository.confirmNewPassword(request);
}
