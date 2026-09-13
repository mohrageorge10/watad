import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/core/theme/app_colors.dart';
import '../../domain/entities/progress_updates_data.dart';
import '../../domain/entities/phase_progress_item.dart';
import '../../domain/entities/site_update_photo.dart';
import '../../domain/repositories/progress_site_updates_repository.dart';
import '../datasources/progress_site_updates_remote_data_source.dart';
import 'package:intl/intl.dart';

class ProgressSiteUpdatesRepositoryImpl implements ProgressSiteUpdatesRepository {
  final ProgressSiteUpdatesRemoteDataSource remoteDataSource;

  ProgressSiteUpdatesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<ProgressUpdatesData>> getProgressUpdates(String projectId) async {
    try {
      // 1. Fetch Timeline Overview
      final timelineRes = await remoteDataSource.getTimelineOverview(projectId);
      if (timelineRes.data == null) {
        return ApiResult.failure(const ServerFailure(errMessage: 'No timeline data found'));
      }
      
      final overallPhysicalProgress = timelineRes.data!.overallPhysicalProgress;

      // 2. Fetch Progress Bargraph
      final bargraphRes = await remoteDataSource.getProgressBargraph(projectId);
      final progressByStage = bargraphRes.progressByStage ?? [];

      final List<PhaseProgressItem> phaseProgressList = progressByStage.map((item) {
        return PhaseProgressItem(
          title: item.stageName,
          percentage: item.actualProgressPercentage,
          indicatorColor: AppColors.primary,
        );
      }).toList();

      // 3. Extract MilestoneId and fetch Archive
      int totalUploads = 0;
      List<SiteUpdatePhoto> siteUpdatePhotos = [];
      
      if (progressByStage.isNotEmpty) {
        final milestoneId = progressByStage.first.milestoneId;
        if (milestoneId.isNotEmpty) {
          final archiveRes = await remoteDataSource.getSiteLogsArchive(projectId, milestoneId);
          if (archiveRes.data != null) {
            totalUploads = archiveRes.data!.totalUploads;
            siteUpdatePhotos = archiveRes.data!.logs.map((log) {
              
              String formattedDate = log.loggedAt;
              try {
                if (log.loggedAt.isNotEmpty) {
                  final parsedDate = DateTime.parse(log.loggedAt);
                  formattedDate = DateFormat('MMM dd, yyyy h:mm a').format(parsedDate);
                }
              } catch (_) {}

              return SiteUpdatePhoto(
                imageUrl: log.primaryImageUrl,
                title: log.title,
                timeText: formattedDate,
              );
            }).toList();
          }
        }
      }

      final summary = ProgressUpdatesData(
        overallProgress: overallPhysicalProgress,
        phaseProgressList: phaseProgressList,
        totalUploads: totalUploads,
        siteUpdatePhotos: siteUpdatePhotos,
      );

      return ApiResult.success(summary);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
