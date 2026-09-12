import 'package:dio/dio.dart';
import 'package:watad/core/errors/error_model.dart';
import 'package:watad/core/errors/exceptions.dart';
import 'package:watad/core/errors/failure.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is ServerException) {
      return ServerFailure(errMessage: error.errorModel.errorMessage);
    } else if (error is CacheException) {
      return CacheFailure(errMessage: error.errorMessage);
    } else {
      return const ServerFailure(errMessage: "An unexpected error occurred. Please try again.");
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(errMessage: "Connection timeout with API server");
      case DioExceptionType.sendTimeout:
        return const ServerFailure(errMessage: "Send timeout with API server");
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(errMessage: "Receive timeout with API server");
      case DioExceptionType.badCertificate:
        return const ServerFailure(errMessage: "Bad SSL certificate");
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response?.statusCode, error.response?.data);
      case DioExceptionType.cancel:
        return const ServerFailure(errMessage: "Request to API server was cancelled");
      case DioExceptionType.connectionError:
        return const NetworkFailure(errMessage: "No internet connection. Please check your network.");
      case DioExceptionType.unknown:
      default:
        return const ServerFailure(errMessage: "Oops! Something went wrong. Please try again.");
    }
  }

  static Failure _handleResponseError(int? statusCode, dynamic responseData) {
    if (responseData != null) {
      final errorModel = ErrorModel.fromJson(responseData);
      if (errorModel.errorMessage.isNotEmpty &&
          errorModel.errorMessage != "An unexpected error occurred") {
        return ServerFailure(errMessage: errorModel.errorMessage);
      }
    }

    switch (statusCode) {
      case 400:
        return const ServerFailure(errMessage: "Bad request. Please check your input.");
      case 401:
        return const ServerFailure(errMessage: "Unauthorized. Please log in again.");
      case 403:
        return const ServerFailure(errMessage: "Forbidden access.");
      case 404:
        return const ServerFailure(errMessage: "Requested resource not found.");
      case 409:
        return const ServerFailure(errMessage: "Conflict occurred. Data already exists.");
      case 500:
        return const ServerFailure(errMessage: "Internal server error. Please try again later.");
      case 502:
      case 503:
      case 504:
        return const ServerFailure(errMessage: "Server is currently unavailable. Please try again later.");
      default:
        return const ServerFailure(errMessage: "Received invalid response from server.");
    }
  }
}
