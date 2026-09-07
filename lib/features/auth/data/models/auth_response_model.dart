import 'package:watad/features/auth/data/models/user_data_model.dart';
import 'package:watad/features/auth/domain/entities/auth_response_entity.dart';

class AuthResponseModel {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final UserDataModel? data;

  const AuthResponseModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    this.data,
  });

  AuthResponseEntity toEntity() => AuthResponseEntity(
        isSuccess: isSuccess,
        statusCode: statusCode,
        message: message,
        user: data?.toEntity(),
      );

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    UserDataModel? userData;
    if (json['data'] is Map<String, dynamic>) {
      userData = UserDataModel.fromJson(json['data'] as Map<String, dynamic>);
    }

    return AuthResponseModel(
      isSuccess: json['isSuccess'] as bool? ?? false,
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '200') ?? 200,
      message: json['message'] as String? ?? '',
      data: userData,
    );
  }
}
