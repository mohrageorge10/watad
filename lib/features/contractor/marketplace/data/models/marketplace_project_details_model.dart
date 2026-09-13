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
    // Title
    final String title = json['title'] as String? ??
        json['projectName'] as String? ??
        'Project Details';

    // Status
    final String status = json['status'] as String? ?? 'Open for Bids';

    // Location
    String location = json['location'] as String? ?? '';
    if (location.isEmpty) {
      final city = json['city'] as String?;
      final gov = json['governorate'] as String?;
      if (city != null && gov != null && city.isNotEmpty && gov.isNotEmpty) {
        location = '$city, $gov';
      } else if (gov != null && gov.isNotEmpty) {
        location = gov;
      } else if (city != null && city.isNotEmpty) {
        location = city;
      } else {
        location = 'Egypt';
      }
    }

    // Images
    List<String> images = (json['images'] as List<dynamic>?)
            ?.map((item) => item.toString())
            .toList() ??
        [];
    if (images.isEmpty && json['photos'] is List) {
      images = (json['photos'] as List).map((e) => e.toString()).toList();
    }
    if (images.isEmpty && json['mediaUrls'] is List) {
      images = (json['mediaUrls'] as List).map((e) => e.toString()).toList();
    }
    if (images.isEmpty && json['image'] != null) {
      images = [json['image'].toString()];
    }
    if (images.isEmpty) {
      images = [
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80',
      ];
    }

    // Specs
    List<MarketplaceSpecItemModel> specs = [];
    if (json['specs'] is List) {
      specs = (json['specs'] as List)
          .map((item) =>
              MarketplaceSpecItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      if (json['landArea'] != null) {
        specs.add(MarketplaceSpecItemModel(
          icon: 'assets/icons/ruler.svg',
          label: 'Land Size',
          value: '${json['landArea']} m²',
        ));
      }
      if (json['floorsCount'] != null) {
        specs.add(MarketplaceSpecItemModel(
          icon: 'assets/icons/layers.svg',
          label: 'Floors',
          value: '${json['floorsCount']} Floors',
        ));
      }
      if (json['finishingLevel'] != null) {
        specs.add(MarketplaceSpecItemModel(
          icon: 'assets/icons/brush.svg',
          label: 'Finishing',
          value: json['finishingLevel'].toString(),
        ));
      }
    }

    // Estimated Budget
    String estimatedBudget = json['estimatedBudget']?.toString() ??
        json['budgetValue']?.toString() ??
        '';
    if (estimatedBudget.isNotEmpty && !estimatedBudget.startsWith('EGP')) {
      final num? numBudget = num.tryParse(estimatedBudget);
      if (numBudget != null) {
        estimatedBudget = 'EGP ${numBudget.toStringAsFixed(0)}';
      } else {
        estimatedBudget = 'EGP $estimatedBudget';
      }
    }

    // Expected Duration
    String expectedDuration = json['expectedDuration'] as String? ?? '';
    if (expectedDuration.isEmpty && json['expectedDurationMonths'] != null) {
      expectedDuration = '${json['expectedDurationMonths']} Months';
    }

    // Dates & Description
    final startDate = json['startDate'] as String? ??
        json['expectedStartDate'] as String? ??
        'Flexible';
    final completionDate = json['completionDate'] as String? ?? 'N/A';
    final description = json['description'] as String? ??
        json['notes'] as String? ??
        'Project open for bidding on the marketplace.';

    // Attachments
    final attachments = (json['attachments'] as List<dynamic>?)
            ?.map((item) => MarketplaceAttachmentModel.fromJson(
                item as Map<String, dynamic>))
            .toList() ??
        const [];

    return MarketplaceProjectDetailsModel(
      id: json['id']?.toString() ?? json['projectId']?.toString() ?? '',
      title: title,
      status: status,
      location: location,
      images: images,
      specs: specs,
      estimatedBudget: estimatedBudget.isNotEmpty ? estimatedBudget : 'EGP 1,500,000',
      expectedDuration: expectedDuration.isNotEmpty ? expectedDuration : '6 Months',
      startDate: startDate,
      completionDate: completionDate,
      description: description,
      attachments: attachments,
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
