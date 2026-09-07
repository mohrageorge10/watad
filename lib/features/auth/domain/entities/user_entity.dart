import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String? fullName;
  final String? email;
  final int? userType;
  final String? role;
  final String? token;
  final String? expirationDate;
  final String? refreshToken;
  final String? refreshTokenExpiration;

  const UserEntity({
    this.userId,
    this.fullName,
    this.email,
    this.userType,
    this.role,
    this.token,
    this.expirationDate,
    this.refreshToken,
    this.refreshTokenExpiration,
  });

  @override
  List<Object?> get props => [
        userId,
        fullName,
        email,
        userType,
        role,
        token,
        expirationDate,
        refreshToken,
        refreshTokenExpiration,
      ];
}
