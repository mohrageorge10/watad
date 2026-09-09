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
  });

  factory ContractorProjectModel.fromJson(Map<String, dynamic> json) {
    final badge = json['badge'] as Map<String, dynamic>?;
    return ContractorProjectModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
      time: json['time'] as String? ?? '',
      image: json['image'] as String? ?? '',
      badgeText: badge?['text'] as String? ?? '',
      badgeColorHex: badge?['color'] as String? ?? '#00B368',
      progress: json['progress'] as String?,
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
    };
  }
}
