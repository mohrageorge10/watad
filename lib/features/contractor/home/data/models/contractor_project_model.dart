import 'package:watad/features/contractor/home/domain/entities/contractor_project_entity.dart';

class ContractorProjectModel extends ContractorProjectEntity {
  const ContractorProjectModel({
    required super.id,
    required super.title,
    required super.location,
    required super.time,
    required super.image,
    required super.badgeText,
    required super.badgeColorHex,
    super.progress,
    super.ownerName,
    super.landArea,
    super.floors,
    super.contractValue,
    super.contractedDate,
    super.contractId,
    super.projectId,
  });

  factory ContractorProjectModel.fromJson(Map<String, dynamic> json) {
    final badge = json['badge'] as Map<String, dynamic>?;
    return ContractorProjectModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? json['projectName'] as String? ?? '',
      location: json['location'] as String? ?? json['governorate'] as String? ?? 'Cairo',
      time: json['time'] as String? ?? '',
      image: json['image'] as String? ?? json['imageUrl'] as String? ?? '',
      badgeText: badge?['text'] as String? ?? json['status'] as String? ?? 'In Progress',
      badgeColorHex: badge?['color'] as String? ?? '#00B368',
      progress: json['progress'] as String?,
      ownerName: json['ownerName'] as String? ?? json['owner']?['name'] as String? ?? 'Ahmed Al-Masry',
      landArea: json['landArea']?.toString() ?? json['area']?.toString() ?? '1,200 m²',
      floors: json['floors']?.toString() ?? json['floorsCount']?.toString() ?? '${json['numberOfFloors'] ?? 2} Floors',
      contractValue: json['estimatedBudget']?.toString() ?? json['contractValue']?.toString() ?? json['cost']?.toString() ?? 'EGP 2,450,000',
      contractedDate: json['createdAt']?.toString() ?? json['contractedDate']?.toString() ?? json['startDate']?.toString() ?? 'Sep 08, 2026',
      contractId: json['contractId']?.toString() ?? json['id']?.toString(),
      projectId: json['projectId']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'time': time,
      'image': image,
      'badge': {
        'text': badgeText,
        'color': badgeColorHex,
      },
      'progress': progress,
      'ownerName': ownerName,
      'landArea': landArea,
      'floors': floors,
      'contractValue': contractValue,
      'contractedDate': contractedDate,
      'contractId': contractId,
      'projectId': projectId,
    };
  }
}
