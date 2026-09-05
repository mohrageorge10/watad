import 'package:dio/dio.dart';
import 'package:watad/core/errors/error_model.dart';

//! ServerException
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);

  @override
  String toString() => errorModel.errorMessage;
}

//! CacheException
class CacheException implements Exception {
  final String errorMessage;
  CacheException({required this.errorMessage});

  @override
  String toString() => errorMessage;
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class ConflictException extends ServerException {
  ConflictException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

void handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(
        ErrorModel(errorMessage: "Connection timeout with server", status: 408),
      );
    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(
        ErrorModel(errorMessage: "Send timeout in connection with server", status: 408),
      );
    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(
        ErrorModel(errorMessage: "Receive timeout in connection with server", status: 408),
      );
    case DioExceptionType.badCertificate:
      throw BadCertificateException(
        ErrorModel(errorMessage: "Bad SSL certificate", status: 495),
      );
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(
        ErrorModel(errorMessage: "No internet connection or connection error", status: 503),
      );
    case DioExceptionType.cancel:
      throw CancelException(
        ErrorModel(errorMessage: "Request to server was cancelled", status: 499),
      );
    case DioExceptionType.badResponse:
      final dynamic responseData = e.response?.data;
      final int? statusCode = e.response?.statusCode;
      final errorModel = ErrorModel.fromJson(responseData);

      switch (statusCode) {
        case 400:
          throw BadResponseException(errorModel);
        case 401:
          throw UnauthorizedException(errorModel);
        case 403:
          throw ForbiddenException(errorModel);
        case 404:
          throw NotFoundException(errorModel);
        case 409:
          throw ConflictException(errorModel);
        case 500:
        case 502:
        case 503:
        case 504:
          throw BadResponseException(
            ErrorModel(
              errorMessage: errorModel.errorMessage.isNotEmpty
                  ? errorModel.errorMessage
                  : "Server error occurred, please try again later",
              status: statusCode,
            ),
          );
        default:
          throw BadResponseException(errorModel);
      }
    case DioExceptionType.unknown:
    default:
      throw UnknownException(
        ErrorModel(
          errorMessage: e.message ?? "An unexpected error occurred",
          status: e.response?.statusCode ?? 500,
        ),
      );
  }
}
