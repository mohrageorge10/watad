import 'package:watad/core/errors/failure.dart';

abstract class ApiResult<T> {
  const ApiResult();

  factory ApiResult.success(T data) = Success<T>;
  factory ApiResult.failure(Failure failure) = FailureResult<T>;

  R fold<R>(
    R Function(T data) onSuccess,
    R Function(Failure failure) onFailure,
  );

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;
  Failure? get failureOrNull =>
      this is FailureResult<T> ? (this as FailureResult<T>).failure : null;
}

class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);

  @override
  R fold<R>(
    R Function(T data) onSuccess,
    R Function(Failure failure) onFailure,
  ) {
    return onSuccess(data);
  }
}

class FailureResult<T> extends ApiResult<T> {
  final Failure failure;
  const FailureResult(this.failure);

  @override
  R fold<R>(
    R Function(T data) onSuccess,
    R Function(Failure failure) onFailure,
  ) {
    return onFailure(failure);
  }
}
