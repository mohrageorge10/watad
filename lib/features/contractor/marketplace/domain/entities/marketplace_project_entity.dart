import 'package:equatable/equatable.dart';

class ProjectSpecsEntity extends Equatable {
  final String land;
  final String scope;

  const ProjectSpecsEntity({
    required this.land,
    required this.scope,
  });

  @override
  List<Object?> get props => [land, scope];
}

class MarketplaceProjectEntity extends Equatable {
  final String id;
  final String title;
  final String location;
  final String image;
  final String timePosted;
  final bool isBookmarked;
  final ProjectSpecsEntity specs;
  final String budgetLabel;
  final String budgetValue;
  final String? category;

  const MarketplaceProjectEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
    required this.timePosted,
    required this.isBookmarked,
    required this.specs,
    required this.budgetLabel,
    required this.budgetValue,
    this.category,
  });

  MarketplaceProjectEntity copyWith({
    String? id,
    String? title,
    String? location,
    String? image,
    String? timePosted,
    bool? isBookmarked,
    ProjectSpecsEntity? specs,
    String? budgetLabel,
    String? budgetValue,
    String? category,
  }) {
    return MarketplaceProjectEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      image: image ?? this.image,
      timePosted: timePosted ?? this.timePosted,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      specs: specs ?? this.specs,
      budgetLabel: budgetLabel ?? this.budgetLabel,
      budgetValue: budgetValue ?? this.budgetValue,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        image,
        timePosted,
        isBookmarked,
        specs,
        budgetLabel,
        budgetValue,
        category,
      ];
}
