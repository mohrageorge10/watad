import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/data/models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequestModel request);
  Future<AuthResponseModel> register(RegisterRequestModel request);
  Future<AuthResponseModel> confirmEmail(ConfirmEmailRequestModel request);
  Future<AuthResponseModel> resendConfirmOtp(String email);
  Future<AuthResponseModel> forgotPassword(ForgotPasswordRequestModel request);
  Future<AuthResponseModel> verifyOtp(VerifyOtpRequestModel request);
  Future<AuthResponseModel> resetPassword(ResetPasswordRequestModel request);
  Future<AuthResponseModel> googleLogin(GoogleLoginRequestModel request);
  Future<AuthResponseModel> facebookLogin(FacebookLoginRequestModel request);
  Future<AuthResponseModel> verifyCurrentPassword(VerifyCurrentPasswordRequestModel request);
  Future<AuthResponseModel> confirmNewPassword(ConfirmNewPasswordRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.login,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.signUp,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> confirmEmail(ConfirmEmailRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.confirmEmail,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> resendConfirmOtp(String email) async {
    final response = await apiConsumer.post(
      EndPoints.resendConfirmOtp,
      queryParameters: {'email': email},
      data: {'email': email},
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> forgotPassword(ForgotPasswordRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.forgetPassword,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> verifyOtp(VerifyOtpRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.verifyOtp,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> resetPassword(ResetPasswordRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.resetPassword,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> googleLogin(GoogleLoginRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.googleLogin,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> facebookLogin(FacebookLoginRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.facebookLogin,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> verifyCurrentPassword(VerifyCurrentPasswordRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.verifyCurrentPassword,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> confirmNewPassword(ConfirmNewPasswordRequestModel request) async {
    final response = await apiConsumer.post(
      EndPoints.confirmNewPassword,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response);
  }
}
