import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';

class ProjectSpecsModel extends ProjectSpecsEntity {
  const ProjectSpecsModel({
    required super.land,
    required super.scope,
  });

  factory ProjectSpecsModel.fromJson(Map<String, dynamic> json) {
    return ProjectSpecsModel(
      land: json['land'] as String? ?? '',
      scope: json['scope'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'land': land,
      'scope': scope,
    };
  }

  factory ProjectSpecsModel.fromEntity(ProjectSpecsEntity entity) {
    return ProjectSpecsModel(
      land: entity.land,
      scope: entity.scope,
    );
  }
}

class MarketplaceProjectModel extends MarketplaceProjectEntity {
  const MarketplaceProjectModel({
    required super.id,
    required super.title,
    required super.location,
    required super.image,
    required super.timePosted,
    required super.isBookmarked,
    required super.specs,
    required super.budgetLabel,
    required super.budgetValue,
    super.category,
  });

  factory MarketplaceProjectModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceProjectModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
      image: json['image'] as String? ?? '',
      timePosted: json['timePosted'] as String? ?? '',
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      specs: json['specs'] != null
          ? ProjectSpecsModel.fromJson(json['specs'] as Map<String, dynamic>)
          : const ProjectSpecsModel(land: '', scope: ''),
      budgetLabel: json['budgetLabel'] as String? ?? 'Est. Budget',
      budgetValue: json['budgetValue'] as String? ?? '',
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'image': image,
      'timePosted': timePosted,
      'isBookmarked': isBookmarked,
      'specs': specs is ProjectSpecsModel
          ? (specs as ProjectSpecsModel).toJson()
          : ProjectSpecsModel.fromEntity(specs).toJson(),
      'budgetLabel': budgetLabel,
      'budgetValue': budgetValue,
      if (category != null) 'category': category,
    };
  }

  factory MarketplaceProjectModel.fromEntity(MarketplaceProjectEntity entity) {
    return MarketplaceProjectModel(
      id: entity.id,
      title: entity.title,
      location: entity.location,
      image: entity.image,
      timePosted: entity.timePosted,
      isBookmarked: entity.isBookmarked,
      specs: entity.specs,
      budgetLabel: entity.budgetLabel,
      budgetValue: entity.budgetValue,
      category: entity.category,
    );
  }
}
