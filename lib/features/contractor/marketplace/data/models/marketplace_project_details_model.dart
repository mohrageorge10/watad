import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_details_entity.dart';

class MarketplaceSpecItemModel extends MarketplaceSpecItemEntity {
  const MarketplaceSpecItemModel({
    required super.icon,
    required super.label,
    required super.value,
  });

  factory MarketplaceSpecItemModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceSpecItemModel(
      icon: json['icon'] as String? ?? '',
      label: json['label'] as String? ?? '',
      value: json['value'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'label': label,
      'value': value,
    };
  }

  factory MarketplaceSpecItemModel.fromEntity(MarketplaceSpecItemEntity entity) {
    return MarketplaceSpecItemModel(
      icon: entity.icon,
      label: entity.label,
      value: entity.value,
    );
  }
}

class MarketplaceAttachmentModel extends MarketplaceAttachmentEntity {
  const MarketplaceAttachmentModel({
    required super.title,
    required super.size,
    super.fileType = 'pdf',
    super.url,
  });

  factory MarketplaceAttachmentModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceAttachmentModel(
      title: json['title'] as String? ?? '',
      size: json['size'] as String? ?? '',
      fileType: json['fileType'] as String? ?? 'pdf',
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'size': size,
      'fileType': fileType,
      if (url != null) 'url': url,
    };
  }

  factory MarketplaceAttachmentModel.fromEntity(MarketplaceAttachmentEntity entity) {
    return MarketplaceAttachmentModel(
      title: entity.title,
      size: entity.size,
      fileType: entity.fileType,
      url: entity.url,
    );
  }
}

class MarketplaceProjectDetailsModel extends MarketplaceProjectDetailsEntity {
  const MarketplaceProjectDetailsModel({
    required super.id,
    required super.title,
    required super.status,
    required super.location,
    required super.images,
    required super.specs,
    required super.estimatedBudget,
    required super.expectedDuration,
    required super.startDate,
    required super.completionDate,
    required super.description,
    required super.attachments,
  });

  factory MarketplaceProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceProjectDetailsModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      status: json['status'] as String? ?? 'Open for Bids',
      location: json['location'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          const [],
      specs: (json['specs'] as List<dynamic>?)
              ?.map((item) => MarketplaceSpecItemModel.fromJson(
                  item as Map<String, dynamic>))
              .toList() ??
          const [],
      estimatedBudget: json['estimatedBudget'] as String? ?? '',
      expectedDuration: json['expectedDuration'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      completionDate: json['completionDate'] as String? ?? '',
      description: json['description'] as String? ?? '',
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((item) => MarketplaceAttachmentModel.fromJson(
                  item as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'location': location,
      'images': images,
      'specs': specs
          .map((s) => s is MarketplaceSpecItemModel
              ? s.toJson()
              : MarketplaceSpecItemModel.fromEntity(s).toJson())
          .toList(),
      'estimatedBudget': estimatedBudget,
      'expectedDuration': expectedDuration,
      'startDate': startDate,
      'completionDate': completionDate,
      'description': description,
      'attachments': attachments
          .map((a) => a is MarketplaceAttachmentModel
              ? a.toJson()
              : MarketplaceAttachmentModel.fromEntity(a).toJson())
          .toList(),
    };
  }

  factory MarketplaceProjectDetailsModel.fromEntity(
      MarketplaceProjectDetailsEntity entity) {
    return MarketplaceProjectDetailsModel(
      id: entity.id,
      title: entity.title,
      status: entity.status,
      location: entity.location,
      images: entity.images,
      specs: entity.specs
          .map((s) => MarketplaceSpecItemModel.fromEntity(s))
          .toList(),
      estimatedBudget: entity.estimatedBudget,
      expectedDuration: entity.expectedDuration,
      startDate: entity.startDate,
      completionDate: entity.completionDate,
      description: entity.description,
      attachments: entity.attachments
          .map((a) => MarketplaceAttachmentModel.fromEntity(a))
          .toList(),
    );
  }
}
