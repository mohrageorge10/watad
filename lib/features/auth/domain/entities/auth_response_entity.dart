import 'package:equatable/equatable.dart';
import 'package:watad/features/auth/domain/entities/user_entity.dart';

class AuthResponseEntity extends Equatable {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final UserEntity? user;

  const AuthResponseEntity({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    this.user,
  });

  @override
  List<Object?> get props => [isSuccess, statusCode, message, user];
}
