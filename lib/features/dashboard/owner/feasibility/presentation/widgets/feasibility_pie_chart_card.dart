import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'legend_item_widget.dart';

class FeasibilityPieChartCard extends StatelessWidget {
  final FeasibilityReport report;

  const FeasibilityPieChartCard({super.key, required this.report});

  List<PieChartSectionData> _getChartSections() {
    final total = report.estimatedTotalCost > 0 ? report.estimatedTotalCost : 1.0;
    
    return [
      PieChartSectionData(
        color: AppColors.primary,
        value: report.materialsCost / total,
        title: '',
        radius: 20.r,
      ),
      PieChartSectionData(
        color: const Color(0xFFFFC107),
        value: report.laborCost / total,
        title: '',
        radius: 20.r,
      ),
      PieChartSectionData(
        color: AppColors.grey400,
        value: report.finishesCost / total,
        title: '',
        radius: 20.r,
      ),
      PieChartSectionData(
        color: AppColors.grey200,
        value: report.contingenciesCost / total,
        title: '',
        radius: 20.r,
      ),
    ];
  }

  int _calculatePercentage(double cost) {
    return report.estimatedTotalCost > 0 
        ? ((cost / report.estimatedTotalCost) * 100).round() 
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120.w,
            height: 120.h,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 40.r,
                sections: _getChartSections(),
              ),
            ),
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendItemWidget(
                  color: AppColors.primary,
                  title: 'Material Cost',
                  cost: report.materialsCost,
                  percentage: _calculatePercentage(report.materialsCost),
                ),
                SizedBox(height: 12.h),
                LegendItemWidget(
                  color: const Color(0xFFFFC107),
                  title: 'Labor Cost',
                  cost: report.laborCost,
                  percentage: _calculatePercentage(report.laborCost),
                ),
                SizedBox(height: 12.h),
                LegendItemWidget(
                  color: AppColors.grey400,
                  title: 'Finishing Cost',
                  cost: report.finishesCost,
                  percentage: _calculatePercentage(report.finishesCost),
                ),
                SizedBox(height: 12.h),
                LegendItemWidget(
                  color: AppColors.grey200,
                  title: 'Contingency',
                  cost: report.contingenciesCost,
                  percentage: _calculatePercentage(report.contingenciesCost),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
