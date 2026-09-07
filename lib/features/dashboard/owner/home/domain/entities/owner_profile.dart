class OwnerProfile {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String role;
  final String? profilePictureUrl;

  const OwnerProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.profilePictureUrl,
  });
}
