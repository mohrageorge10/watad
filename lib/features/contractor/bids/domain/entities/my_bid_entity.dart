import 'package:equatable/equatable.dart';

class MyBidEntity extends Equatable {
  final String id;
  final String projectId;
  final String title;
  final String location;
  final String image;
  final String status;
  final String statusColorHex;
  final bool isBookmarked;
  final String yourBid;
  final String duration;
  final String submittedDate;
  final String? rejectionReason;
  final String landArea;
  final String floors;
  final String finishingLevel;
  final String description;
  final String proposal;
  final String? attachmentUrl;
  final String? attachmentName;
  final String startDate;
  final String completionDate;
  final List<String> images;

  const MyBidEntity({
    required this.id,
    this.projectId = '',
    required this.title,
    required this.location,
    required this.image,
    required this.status,
    required this.statusColorHex,
    required this.isBookmarked,
    required this.yourBid,
    required this.duration,
    required this.submittedDate,
    this.rejectionReason,
    this.landArea = '-',
    this.floors = '-',
    this.finishingLevel = '-',
    this.description = 'No description provided.',
    this.proposal = '',
    this.attachmentUrl,
    this.attachmentName,
    this.startDate = '-',
    this.completionDate = '-',
    this.images = const [],
  });

  @override
  List<Object?> get props => [
        id,
        projectId,
        title,
        location,
        image,
        status,
        statusColorHex,
        isBookmarked,
        yourBid,
        duration,
        submittedDate,
        rejectionReason,
        landArea,
        floors,
        finishingLevel,
        description,
        proposal,
        attachmentUrl,
        attachmentName,
        startDate,
        completionDate,
        images,
      ];
}
