import 'package:flutter/material.dart';

class BudgetBreakdownItem {
  final String title;
  final String value;
  final String? percentage;
  final Color color;

  BudgetBreakdownItem({
    required this.title,
    required this.value,
    this.percentage,
    required this.color,
  });
}

class QuickStat {
  final String title;
  final String value;
  final String percentage;

  QuickStat({
    required this.title,
    required this.value,
    required this.percentage,
  });
}

class PaymentItem {
  final String title;
  final String subtitle;
  final String date;
  final String value;
  final String status;
  final Color statusColor;

  PaymentItem({
    required this.title,
    this.subtitle = '',
    required this.date,
    required this.value,
    required this.status,
    required this.statusColor,
  });
}

class FinancialSummaryData {
  final String totalBudget;
  final List<BudgetBreakdownItem> breakdowns;
  final List<QuickStat> quickStats;
  final List<PaymentItem> latestPayments;

  FinancialSummaryData({
    required this.totalBudget,
    required this.breakdowns,
    required this.quickStats,
    required this.latestPayments,
  });
}
