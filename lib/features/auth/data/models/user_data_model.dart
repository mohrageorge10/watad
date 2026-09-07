import 'package:watad/features/auth/domain/entities/user_entity.dart';

class UserDataModel {
  final String? userId;
  final String? fullName;
  final String? email;
  final int? userType;
  final String? role;
  final String? token;
  final String? expirationDate;
  final String? refreshToken;
  final String? refreshTokenExpiration;

  const UserDataModel({
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

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userId: json['userId'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      userType: json['userType'] is int
          ? json['userType'] as int
          : int.tryParse(json['userType']?.toString() ?? ''),
      role: json['role'] as String?,
      token: (json['token'] ?? json['resetToken']) as String?,
      expirationDate: json['expirationDate'] as String?,
      refreshToken: json['refreshToken'] as String?,
      refreshTokenExpiration: json['refreshTokenExpiration'] as String?,
    );
  }

  UserEntity toEntity() => UserEntity(
        userId: userId,
        fullName: fullName,
        email: email,
        userType: userType,
        role: role,
        token: token,
        expirationDate: expirationDate,
        refreshToken: refreshToken,
        refreshTokenExpiration: refreshTokenExpiration,
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'userType': userType,
      'role': role,
      'token': token,
      'expirationDate': expirationDate,
      'refreshToken': refreshToken,
      'refreshTokenExpiration': refreshTokenExpiration,
    };
  }
}
