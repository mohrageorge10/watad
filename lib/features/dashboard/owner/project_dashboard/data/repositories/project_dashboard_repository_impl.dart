import 'package:flutter/material.dart';
import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/core/network/api/api_result.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/project_dashboard_repository.dart';
import '../datasources/project_dashboard_remote_data_source.dart';

class ProjectDashboardRepositoryImpl implements ProjectDashboardRepository {
  final ProjectDashboardRemoteDataSource remoteDataSource;

  ProjectDashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<DashboardData>> getDashboardData(String projectId) async {
    try {
      final response = await remoteDataSource.getTimelineOverview(projectId);

      if (!response.isSuccess || response.data == null) {
        return ApiResult.failure(
          ServerFailure(
            errMessage: response.message.isNotEmpty
                ? response.message
                : 'Failed to load timeline overview',
          ),
        );
      }

      final data = response.data!;

      // 4 Quick Access boxes remain strictly static as required
      final staticQuickAccessItems = [
        QuickAccessItem(
          title: 'Financial\nSummary',
          iconData: Icons.credit_card_outlined,
        ),
        QuickAccessItem(
          title: 'Change\nOrders',
          iconData: Icons.description_outlined,
          notificationCount: 2,
        ),
        QuickAccessItem(
          title: 'Progress &\nSite Updates',
          iconData: Icons.image_outlined,
        ),
        QuickAccessItem(
          title: 'Alerts &\nActivity Feed',
          iconData: Icons.notifications_none_outlined,
        ),
      ];

      return ApiResult.success(
        DashboardData(
          projectName: data.projectTitle,
          progress: ConstructionProgress(
            overallPercentage: data.overallPhysicalProgress,
            elapsedPercentage: data.timeElapsedPercentage,
            currentStage: data.currentStageName,
            stageStatus: data.currentStageStatus,
            daysToFinish: data.daysUntilPlannedCompletion,
          ),
          quickAccessItems: staticQuickAccessItems,
          milestones: data.milestones,
        ),
      );
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}