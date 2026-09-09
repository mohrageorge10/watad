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

  const MarketplaceLoading({this.activeChip = 'All'});

  @override
  List<Object?> get props => [activeChip];
}

class MarketplaceSuccess extends MarketplaceState {
  final List<MarketplaceProjectEntity> projects;
  final String activeChip;
  final String searchQuery;

  const MarketplaceSuccess({
    required this.projects,
    this.activeChip = 'All',
    this.searchQuery = '',
  });

  MarketplaceSuccess copyWith({
    List<MarketplaceProjectEntity>? projects,
    String? activeChip,
    String? searchQuery,
  }) {
    return MarketplaceSuccess(
      projects: projects ?? this.projects,
      activeChip: activeChip ?? this.activeChip,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [projects, activeChip, searchQuery];
}

class MarketplaceEmpty extends MarketplaceState {
  final String message;
  final String activeChip;

  const MarketplaceEmpty({
    this.message = 'No projects found in marketplace',
    this.activeChip = 'All',
  });

  @override
  List<Object?> get props => [message, activeChip];
}

class MarketplaceError extends MarketplaceState {
  final String message;
  final String activeChip;

  const MarketplaceError({
    required this.message,
    this.activeChip = 'All',
  });

  @override
  List<Object?> get props => [message, activeChip];
}
