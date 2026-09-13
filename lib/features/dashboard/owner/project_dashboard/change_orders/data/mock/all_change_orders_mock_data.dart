class AllChangeOrdersMockData {
  const AllChangeOrdersMockData._();

  static const Map<String, dynamic> payload = {
    'pendingCount': 3,
    'pendingCostImpact': 24750,
    'pendingDaysImpact': 7,
    'totalOrders': 18,
    'pendingOrders': [
      {
        'code': 'CO-004',
        'title': 'Increase pile depth – foundation',
        'description': 'Due to soil condition on site',
        'costImpact': 15000,
        'timeImpactDays': 5,
        'requestedBy': 'Contractor',
        'requestedAt': '2024-05-20',
        'status': 'Pending',
      },
      {
        'code': 'CO-003',
        'title': 'Change tile type in bathrooms',
        'description': 'Change from ceramic to marble',
        'costImpact': 8500,
        'timeImpactDays': 2,
        'requestedBy': 'Contractor',
        'requestedAt': '2024-05-19',
        'status': 'Pending',
      },
      {
        'code': 'CO-002',
        'title': 'Add extra electrical outlet points',
        'description': 'Additional outlets in kitchen & living',
        'costImpact': 2000,
        'timeImpactDays': 1,
        'requestedBy': 'Contractor',
        'requestedAt': '2024-05-18',
        'status': 'Pending',
      },
    ],
  };
}
