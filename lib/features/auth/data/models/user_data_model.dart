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
    int? parseUserType(dynamic val) {
      if (val is int) return val;
      if (val == null) return null;
      final parsed = int.tryParse(val.toString());
      if (parsed != null) return parsed;
      final lower = val.toString().trim().toLowerCase();
      switch (lower) {
        case 'owner':
        case 'project owner':
        case 'projectowner':
          return 0;
        case 'engineer':
          return 1;
        case 'contractor':
          return 2;
        case 'consultant':
          return 3;
        case 'supplier':
          return 4;
        default:
          return null;
      }
    }

    final parsedUserType = parseUserType(json['userType'] ?? json['UserType']);
    String? resolvedRole = (json['role'] ?? json['Role'] ?? json['userRole']) as String?;
    if (resolvedRole == null && parsedUserType != null) {
      switch (parsedUserType) {
        case 0:
          resolvedRole = 'Project Owner';
          break;
        case 1:
          resolvedRole = 'Engineer';
          break;
        case 2:
          resolvedRole = 'Contractor';
          break;
        case 3:
          resolvedRole = 'Consultant';
          break;
        case 4:
          resolvedRole = 'Supplier';
          break;
      }
    }

    return UserDataModel(
      userId: (json['userId'] ?? json['id'] ?? json['nameid']) as String?,
      fullName: (json['fullName'] ?? json['name'] ?? json['userName']) as String?,
      email: json['email'] as String?,
      userType: parsedUserType,
      role: resolvedRole,
      token: (json['token'] ?? json['resetToken']) as String?,
      expirationDate: (json['expirationDate'] ?? json['expiration']) as String?,
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
