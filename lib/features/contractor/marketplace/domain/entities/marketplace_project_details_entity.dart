import 'package:equatable/equatable.dart';

class MarketplaceSpecItemEntity extends Equatable {
  final String icon;
  final String label;
  final String value;

  const MarketplaceSpecItemEntity({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  List<Object?> get props => [icon, label, value];
}

class MarketplaceAttachmentEntity extends Equatable {
  final String title;
  final String size;
  final String fileType;
  final String? url;

  const MarketplaceAttachmentEntity({
    required this.title,
    required this.size,
    this.fileType = 'pdf',
    this.url,
  });

  @override
  List<Object?> get props => [title, size, fileType, url];
}

class MarketplaceProjectDetailsEntity extends Equatable {
  final String id;
  final String title;
  final String status;
  final String location;
  final List<String> images;
  final List<MarketplaceSpecItemEntity> specs;
  final String estimatedBudget;
  final String expectedDuration;
  final String startDate;
  final String completionDate;
  final String description;
  final List<MarketplaceAttachmentEntity> attachments;

  const MarketplaceProjectDetailsEntity({
    required this.id,
    required this.title,
    required this.status,
    required this.location,
    required this.images,
    required this.specs,
    required this.estimatedBudget,
    required this.expectedDuration,
    required this.startDate,
    required this.completionDate,
    required this.description,
    required this.attachments,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        status,
        location,
        images,
        specs,
        estimatedBudget,
        expectedDuration,
        startDate,
        completionDate,
        description,
        attachments,
      ];
}
