import 'package:equatable/equatable.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/project_summary.dart';

class PaginatedProjects extends Equatable {
  final List<ProjectSummary> items;
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;

  const PaginatedProjects({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
  });

  @override
  List<Object?> get props => [
        items,
        currentPage,
        totalPages,
        pageSize,
        totalCount,
        hasPrevious,
        hasNext,
      ];
}
