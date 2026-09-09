import 'package:watad/features/dashboard/owner/home/domain/entities/owner_profile.dart';

class OwnerProfileModel extends OwnerProfile {
  const OwnerProfileModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    super.profilePictureUrl,
  });

  factory OwnerProfileModel.fromJson(Map<String, dynamic> json) {
    return OwnerProfileModel(
      id: json['id'] as String? ?? '',
      fullName: (json['fullName'] ?? json['name'] ?? json['userName'] ?? '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim()) as String,
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      role: json['role'] as String? ?? '',
      profilePictureUrl: json['profilePictureUrl'] as String?,
    );
  }
}
