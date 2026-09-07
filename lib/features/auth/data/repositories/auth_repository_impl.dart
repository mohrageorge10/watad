import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/domain/entities/auth_response_entity.dart';
import 'package:watad/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<AuthResponseEntity>> login(LoginRequestModel request) async {
    try {
      final response = await remoteDataSource.login(request);
      if (!response.isSuccess) {
        return ApiResult.failure(ServerFailure(errMessage: response.message));
      }
      return ApiResult.success(response.toEntity());
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AuthResponseEntity>> register(RegisterRequestModel request) async {
    try {
      final response = await remoteDataSource.register(request);
      if (!response.isSuccess) {
        return ApiResult.failure(ServerFailure(errMessage: response.message));
      }
      return ApiResult.success(response.toEntity());
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AuthResponseEntity>> confirmEmail(ConfirmEmailRequestModel request) async {
    try {
      final response = await remoteDataSource.confirmEmail(request);
      if (!response.isSuccess) {
        return ApiResult.failure(ServerFailure(errMessage: response.message));
      }
      return ApiResult.success(response.toEntity());
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AuthResponseEntity>> resendConfirmOtp(String email) async {
    try {
      final response = await remoteDataSource.resendConfirmOtp(email);
      if (!response.isSuccess) {
        return ApiResult.failure(ServerFailure(errMessage: response.message));
      }
      return ApiResult.success(response.toEntity());
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AuthResponseEntity>> forgotPassword(ForgotPasswordRequestModel request) async {
    try {
      final response = await remoteDataSource.forgotPassword(request);
      if (!response.isSuccess) {
        return ApiResult.failure(ServerFailure(errMessage: response.message));
      }
      return ApiResult.success(response.toEntity());
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AuthResponseEntity>> verifyOtp(VerifyOtpRequestModel request) async {
    try {
      final response = await remoteDataSource.verifyOtp(request);
      if (!response.isSuccess) {
        return ApiResult.failure(ServerFailure(errMessage: response.message));
      }
      return ApiResult.success(response.toEntity());
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AuthResponseEntity>> resetPassword(ResetPasswordRequestModel request) async {
    try {
      final response = await remoteDataSource.resetPassword(request);
      if (!response.isSuccess) {
        return ApiResult.failure(ServerFailure(errMessage: response.message));
      }
      return ApiResult.success(response.toEntity());
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AuthResponseEntity>> googleLogin(GoogleLoginRequestModel request) async {
    try {
      final response = await remoteDataSource.googleLogin(request);
      if (!response.isSuccess) {
        return ApiResult.failure(ServerFailure(errMessage: response.message));
      }
      return ApiResult.success(response.toEntity());
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AuthResponseEntity>> facebookLogin(FacebookLoginRequestModel request) async {
    try {
      final response = await remoteDataSource.facebookLogin(request);
      if (!response.isSuccess) {
        return ApiResult.failure(ServerFailure(errMessage: response.message));
      }
      return ApiResult.success(response.toEntity());
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
