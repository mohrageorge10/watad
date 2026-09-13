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
    // 1. Title
    final String title = json['title'] as String? ??
        json['projectName'] as String? ??
        'Construction Project';

    // 2. Location
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

    // 3. Image
    String image = json['image'] as String? ?? json['imageUrl'] as String? ?? '';
    if (image.isEmpty && json['photos'] is List && (json['photos'] as List).isNotEmpty) {
      image = (json['photos'] as List).first.toString();
    }
    if (image.isEmpty && json['mediaUrls'] is List && (json['mediaUrls'] as List).isNotEmpty) {
      image = (json['mediaUrls'] as List).first.toString();
    }
    if (image.isEmpty) {
      image = 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80';
    }

    // 4. Time Posted
    final timePosted = json['timePosted'] as String? ??
        json['startDate'] as String? ??
        json['createdDate'] as String? ??
        'Recently';

    // 5. Specs
    ProjectSpecsModel specs;
    if (json['specs'] is Map<String, dynamic>) {
      specs = ProjectSpecsModel.fromJson(json['specs'] as Map<String, dynamic>);
    } else {
      final landArea = json['landArea'] != null
          ? '${json['landArea']} m²'
          : (json['area'] != null ? '${json['area']} m²' : 'N/A');
      final floors = json['floorsCount'] != null
          ? '${json['floorsCount']} Floors'
          : (json['floors'] != null ? json['floors'].toString() : '');
      final finishing = json['finishingLevel'] as String? ?? '';
      final scopeList = [if (floors.isNotEmpty) floors, if (finishing.isNotEmpty) finishing];
      final scope = scopeList.isNotEmpty
          ? scopeList.join(' · ')
          : (json['scope'] as String? ?? 'General Scope');
      specs = ProjectSpecsModel(land: landArea, scope: scope);
    }

    // 6. Budget
    final budgetLabel = json['budgetLabel'] as String? ?? 'Est. Budget';
    String budgetValue = json['budgetValue'] as String? ?? '';
    if (budgetValue.isEmpty && json['estimatedBudget'] != null) {
      final num? numBudget = num.tryParse(json['estimatedBudget'].toString());
      budgetValue = numBudget != null
          ? 'EGP ${numBudget.toStringAsFixed(0)}'
          : 'EGP ${json['estimatedBudget']}';
    }
    if (budgetValue.isEmpty) {
      budgetValue = 'EGP 1,500,000';
    }

    final category = json['category'] as String? ?? json['governorate'] as String?;

    return MarketplaceProjectModel(
      id: json['id']?.toString() ?? json['projectId']?.toString() ?? '',
      title: title,
      location: location,
      image: image,
      timePosted: timePosted,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      specs: specs,
      budgetLabel: budgetLabel,
      budgetValue: budgetValue,
      category: category,
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
