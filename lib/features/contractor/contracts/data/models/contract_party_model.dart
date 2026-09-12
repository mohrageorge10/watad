class ContractPartyModel {
  final String role;
  final String name;
  final bool isSigned;
  final String statusText;
  final bool isUnsignedRejected;

  const ContractPartyModel({
    required this.role,
    required this.name,
    required this.isSigned,
    required this.statusText,
    this.isUnsignedRejected = false,
  });

  ContractPartyModel copyWith({
    String? role,
    String? name,
    bool? isSigned,
    String? statusText,
    bool? isUnsignedRejected,
  }) {
    return ContractPartyModel(
      role: role ?? this.role,
      name: name ?? this.name,
      isSigned: isSigned ?? this.isSigned,
      statusText: statusText ?? this.statusText,
      isUnsignedRejected: isUnsignedRejected ?? this.isUnsignedRejected,
    );
  }
}
