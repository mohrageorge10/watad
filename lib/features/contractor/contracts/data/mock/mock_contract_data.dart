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
}

class MockContractData {
  MockContractData._();

  // General Context
  static const String projectContextSubtitle = 'PROJECT CONTEXT';
  static const String projectName = 'Villa Construction Project - New Cairo';

  // Preview Card
  static const String previewProjectTitle = 'Modern Villa Alpha';
  static const String previewLocation = 'New Cairo, Cairo';
  static const String previewImage =
      'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=400&q=80';
  static const String previewSignedDate = 'Sep 08, 2026';
  static const String previewDocumentName = 'Contract_Document.pdf';
  static const String previewDocumentSize = '2.8 MB';

  // Metrics
  static const String contractValue = 'EGP 2,450,000';
  static const String duration = '6 Months';
  static const String startDate = 'Nov 01, 2026';
  static const String endDate = 'May 01, 2027';

  // Parties for Contract Details & Sign
  static const List<ContractPartyModel> parties = [
    ContractPartyModel(
      role: 'Owner',
      name: 'Ahmed Al-Masry',
      isSigned: true,
      statusText: 'Signed digitally on Sep 08, 2026',
    ),
    ContractPartyModel(
      role: 'Contractor',
      name: 'Al-Rayan\nConstruction',
      isSigned: true,
      statusText: 'Signed digitally on Sep 08,\n2026',
    ),
    ContractPartyModel(
      role: 'Consultant (Optional)',
      name: 'Eng. Sameer El-Naggar',
      isSigned: false,
      statusText: 'Not signed',
      isUnsignedRejected: false,
    ),
  ];

  // Parties for Contract Preview Screen (matching Marketplace (7).png)
  static const List<ContractPartyModel> previewParties = [
    ContractPartyModel(
      role: 'Owner',
      name: 'Ahmed Al-Masry',
      isSigned: true,
      statusText: 'Signed digitally on Sep 08, 2026',
    ),
    ContractPartyModel(
      role: 'Contractor',
      name: 'Al-Rayan\nConstruction',
      isSigned: true,
      statusText: 'Signed digitally on Sep 08,\n2026',
    ),
    ContractPartyModel(
      role: 'Consultant (Optional)',
      name: 'Eng. Sameer El-Naggar',
      isSigned: false,
      statusText: 'Not signed',
      isUnsignedRejected: true,
    ),
  ];

  static const List<String> terms = [
    '1. Scope of Work',
    '2. Payment Schedule',
    '3. Project Milestones',
    '4. Responsibilities',
    '5. Penalties & Delays',
    '6. Completion Conditions',
  ];

  static const String signatureDisclaimer =
      'Your signature will be added to the contract document before final submission.';

  static const String successBannerText =
      'Contract has been signed successfully on Sep 08, 2026.';
}
