import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/features/contractor/marketplace/data/mock/mock_marketplace_data.dart';
import 'package:watad/features/contractor/marketplace/data/models/marketplace_project_model.dart';

abstract class MarketplaceRemoteDataSource {
  Future<List<MarketplaceProjectModel>> getMarketplaceProjects({
    String? category,
    String? searchQuery,
  });
}

class MarketplaceRemoteDataSourceImpl implements MarketplaceRemoteDataSource {
  final ApiConsumer? apiConsumer;

  MarketplaceRemoteDataSourceImpl({this.apiConsumer});

  @override
  Future<List<MarketplaceProjectModel>> getMarketplaceProjects({
    String? category,
    String? searchQuery,
  }) async {
    // Simulate network latency for authentic feel
    await Future.delayed(const Duration(milliseconds: 600));

    var projects = MockMarketplaceData.getProjects();

    if (category != null && category.isNotEmpty && category != 'All') {
      if (category == 'Budget') {
        // Sort by budget value ascending or filter
        projects = [...projects]..sort((a, b) {
            final aVal = _extractBudgetNumber(a.budgetValue);
            final bVal = _extractBudgetNumber(b.budgetValue);
            return aVal.compareTo(bVal);
          });
      } else {
        projects = projects
            .where((p) =>
                p.category?.toLowerCase() == category.toLowerCase() ||
                p.location.toLowerCase().contains(category.toLowerCase()))
            .toList();
      }
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      projects = projects
          .where((p) =>
              p.title.toLowerCase().contains(query) ||
              p.location.toLowerCase().contains(query))
          .toList();
    }

    return projects;
  }

  int _extractBudgetNumber(String budget) {
    final cleaned = budget.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }
}
