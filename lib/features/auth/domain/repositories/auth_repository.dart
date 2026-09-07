import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/domain/entities/auth_response_entity.dart';

abstract class AuthRepository {
  Future<ApiResult<AuthResponseEntity>> login(LoginRequestModel request);
  Future<ApiResult<AuthResponseEntity>> register(RegisterRequestModel request);
  Future<ApiResult<AuthResponseEntity>> confirmEmail(ConfirmEmailRequestModel request);
  Future<ApiResult<AuthResponseEntity>> resendConfirmOtp(String email);
  Future<ApiResult<AuthResponseEntity>> forgotPassword(ForgotPasswordRequestModel request);
  Future<ApiResult<AuthResponseEntity>> verifyOtp(VerifyOtpRequestModel request);
  Future<ApiResult<AuthResponseEntity>> resetPassword(ResetPasswordRequestModel request);
  Future<ApiResult<AuthResponseEntity>> googleLogin(GoogleLoginRequestModel request);
  Future<ApiResult<AuthResponseEntity>> facebookLogin(FacebookLoginRequestModel request);
}
