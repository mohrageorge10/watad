import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errMessage;
  const Failure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.errMessage});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.errMessage});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.errMessage = "No internet connection"});
}
