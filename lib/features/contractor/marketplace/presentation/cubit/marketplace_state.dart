import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';

abstract class MarketplaceState extends Equatable {
  const MarketplaceState();

  @override
  List<Object?> get props => [];
}

class MarketplaceInitial extends MarketplaceState {
  const MarketplaceInitial();
}

class MarketplaceLoading extends MarketplaceState {
  final String activeChip;
  final int? minBudget;

  const MarketplaceLoading({
    this.activeChip = 'All',
    this.minBudget,
  });

  @override
  List<Object?> get props => [activeChip, minBudget];
}

class MarketplaceSuccess extends MarketplaceState {
  final List<MarketplaceProjectEntity> projects;
  final String activeChip;
  final String searchQuery;
  final int? minBudget;

  const MarketplaceSuccess({
    required this.projects,
    this.activeChip = 'All',
    this.searchQuery = '',
    this.minBudget,
  });

  MarketplaceSuccess copyWith({
    List<MarketplaceProjectEntity>? projects,
    String? activeChip,
    String? searchQuery,
    int? minBudget,
  }) {
    return MarketplaceSuccess(
      projects: projects ?? this.projects,
      activeChip: activeChip ?? this.activeChip,
      searchQuery: searchQuery ?? this.searchQuery,
      minBudget: minBudget ?? this.minBudget,
    );
  }

  @override
  List<Object?> get props => [projects, activeChip, searchQuery, minBudget];
}

class MarketplaceEmpty extends MarketplaceState {
  final String message;
  final String activeChip;
  final int? minBudget;

  const MarketplaceEmpty({
    this.message = 'No projects found in marketplace',
    this.activeChip = 'All',
    this.minBudget,
  });

  @override
  List<Object?> get props => [message, activeChip, minBudget];
}

class MarketplaceError extends MarketplaceState {
  final String message;
  final String activeChip;
  final int? minBudget;

  const MarketplaceError({
    required this.message,
    this.activeChip = 'All',
    this.minBudget,
  });

  @override
  List<Object?> get props => [message, activeChip, minBudget];
}
