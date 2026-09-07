

import 'package:watad/features/dashboard/owner/home/data/models/project_summary_model.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/paginated_projects.dart';

class PaginatedProjectsModel extends PaginatedProjects {
  const PaginatedProjectsModel({
    required super.items,
    required super.currentPage,
    required super.totalPages,
    required super.pageSize,
    required super.totalCount,
    required super.hasPrevious,
    required super.hasNext,
  });

  factory PaginatedProjectsModel.fromJson(Map<String, dynamic> json) {
    final rawItems = (json['items'] as List?) ?? const [];
    return PaginatedProjectsModel(
      items: rawItems
          .map((e) => ProjectSummaryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      hasPrevious: json['hasPrevious'] as bool? ?? false,
      hasNext: json['hasNext'] as bool? ?? false,
    );
  }
}
