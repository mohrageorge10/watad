import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';

class MyBidModel extends MyBidEntity {
  const MyBidModel({
    required super.id,
    super.projectId,
    required super.title,
    required super.location,
    required super.image,
    required super.status,
    required super.statusColorHex,
    required super.isBookmarked,
    required super.yourBid,
    required super.duration,
    required super.submittedDate,
    super.rejectionReason,
    super.landArea,
    super.floors,
    super.finishingLevel,
    super.description,
    super.proposal,
    super.attachmentUrl,
    super.attachmentName,
    super.startDate,
    super.completionDate,
    super.images,
  });

  factory MyBidModel.fromJson(Map<String, dynamic> json) {
    final stats = json['stats'] as Map<String, dynamic>?;
    final actions = json['actions'] as Map<String, dynamic>?;
    final projectMap = json['project'] as Map<String, dynamic>?;

    // 0. Project ID
    final projectId = json['projectId']?.toString() ??
        projectMap?['id']?.toString() ??
        projectMap?['projectId']?.toString() ??
        '';

    // 1. Title
    final title = json['projectTitle'] as String? ??
        json['title'] as String? ??
        json['projectName'] as String? ??
        projectMap?['title'] as String? ??
        projectMap?['projectName'] as String? ??
        'Project Bid';

    // 2. Location
    String location = json['location'] as String? ??
        projectMap?['location'] as String? ??
        '';
    if (location.isEmpty) {
      final city = json['city'] as String? ?? projectMap?['city'] as String?;
      final gov = json['governorate'] as String? ??
          projectMap?['governorate'] as String?;
      if (city != null && gov != null && city.isNotEmpty && gov.isNotEmpty) {
        location = '$city, $gov';
      } else if (gov != null && gov.isNotEmpty) {
        location = gov;
      } else if (city != null && city.isNotEmpty) {
        location = city;
      } else {
        location = 'Egypt';
      }
    }

    // 3. Status
    String status = 'Pending Review';
    String statusColorHex = '#FFB020';
    final rawStatus = json['status'] ?? json['bidStatus'];
    if (rawStatus is int) {
      switch (rawStatus) {
        case 1:
          status = 'Accepted';
          statusColorHex = '#34C759';
          break;
        case 2:
          status = 'Rejected';
          statusColorHex = '#FF3B30';
          break;
        default:
          status = 'Pending Review';
          statusColorHex = '#FFB020';
      }
    } else if (rawStatus is String && rawStatus.isNotEmpty) {
      final s = rawStatus.toLowerCase();
      if (s.contains('accept')) {
        status = 'Accepted';
        statusColorHex = '#34C759';
      } else if (s.contains('reject')) {
        status = 'Rejected';
        statusColorHex = '#FF3B30';
      } else {
        status = 'Pending Review';
        statusColorHex = '#FFB020';
      }
    }

    // 4. Images & Primary Image
    List<String> images = [];
    if (json['photos'] is List && (json['photos'] as List).isNotEmpty) {
      images = (json['photos'] as List).map((e) => e.toString()).toList();
    } else if (projectMap?['photos'] is List &&
        (projectMap!['photos'] as List).isNotEmpty) {
      images = (projectMap['photos'] as List).map((e) => e.toString()).toList();
    } else if (json['images'] is List && (json['images'] as List).isNotEmpty) {
      images = (json['images'] as List).map((e) => e.toString()).toList();
    } else if (projectMap?['images'] is List &&
        (projectMap!['images'] as List).isNotEmpty) {
      images = (projectMap['images'] as List).map((e) => e.toString()).toList();
    } else if (json['mediaUrls'] is List &&
        (json['mediaUrls'] as List).isNotEmpty) {
      images = (json['mediaUrls'] as List).map((e) => e.toString()).toList();
    }

    String image = json['image'] as String? ??
        json['projectPhoto'] as String? ??
        json['imageUrl'] as String? ??
        projectMap?['image'] as String? ??
        projectMap?['imageUrl'] as String? ??
        '';
    if (image.isEmpty && images.isNotEmpty) {
      image = images.first;
    }
    if (image.isNotEmpty && images.isEmpty) {
      images = [image];
    }
    if (image.isEmpty) {
      image =
          'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80';
    }

    // 5. Your Bid
    String yourBid =
        stats?['yourBid'] as String? ?? json['yourBid'] as String? ?? '';
    if (yourBid.isEmpty) {
      final rawCost = json['proposedCost'] ?? json['cost'] ?? json['amount'];
      if (rawCost != null) {
        final num? val = num.tryParse(rawCost.toString());
        yourBid =
            val != null ? 'EGP ${val.toStringAsFixed(0)}' : 'EGP $rawCost';
      }
    }
    if (yourBid.isEmpty) yourBid = 'EGP 0';

    // 6. Duration
    String duration =
        stats?['duration'] as String? ?? json['duration'] as String? ?? '';
    if (duration.isEmpty) {
      final rawDays = json['proposedDurationDays'] ??
          json['proposedDuration'] ??
          json['durationDays'];
      if (rawDays != null) {
        final num? days = num.tryParse(rawDays.toString());
        if (days != null) {
          final months = (days / 30).round();
          duration = months > 0 ? '$months Months' : '$days Days';
        }
      }
    }
    if (duration.isEmpty) duration = '6 Months';

    // 7. Submitted Date
    String submittedDate = stats?['submitted'] as String? ??
        json['submittedDate'] as String? ??
        json['createdAt'] as String? ??
        '';
    if (submittedDate.contains('T')) {
      submittedDate = submittedDate.split('T').first;
    }
    if (submittedDate.isEmpty) submittedDate = 'Recently';

    // 8. Land Area
    String landArea = '-';
    final rawLand = json['landArea'] ??
        projectMap?['landArea'] ??
        json['area'] ??
        projectMap?['area'];
    if (rawLand != null && rawLand.toString().trim().isNotEmpty) {
      final str = rawLand.toString().trim();
      landArea = str.toLowerCase().contains('m') ? str : '$str m²';
    }

    // 9. Floors
    String floors = '-';
    final rawFloors = json['floorsCount'] ??
        projectMap?['floorsCount'] ??
        json['floors'] ??
        projectMap?['floors'];
    if (rawFloors != null && rawFloors.toString().trim().isNotEmpty) {
      final str = rawFloors.toString().trim();
      floors = str.toLowerCase().contains('floor') ? str : '$str Floors';
    }

    // 10. Finishing Level
    String finishingLevel = '-';
    final rawFinishing = json['finishingLevel'] ??
        projectMap?['finishingLevel'] ??
        json['finishing'];
    if (rawFinishing != null && rawFinishing.toString().trim().isNotEmpty) {
      finishingLevel = rawFinishing.toString().trim();
    }

    // 11. Description & Proposal
    String description = '-';
    final rawDesc = json['description'] ??
        projectMap?['description'] ??
        json['projectDescription'] ??
        json['notes'] ??
        projectMap?['notes'] ??
        json['technicalProposal'];
    if (rawDesc != null && rawDesc.toString().trim().isNotEmpty) {
      description = rawDesc.toString().trim();
    }

    // Explicit Technical Proposal
    String proposal = '';
    final rawProp = json['technicalProposal'] ??
        json['proposal'] ??
        json['technicalProposalText'] ??
        json['notes'];
    if (rawProp != null && rawProp.toString().trim().isNotEmpty) {
      proposal = rawProp.toString().trim();
    } else if (description != '-' &&
        description != 'No description provided.' &&
        !description.startsWith('Project in ')) {
      proposal = description;
    }

    // Explicit Attachment
    String? attachmentUrl = json['technicalProposalUrl'] as String? ??
        json['attachmentUrl'] as String? ??
        json['fileUrl'] as String? ??
        json['attachment'] as String? ??
        json['mediaUrl'] as String?;

    String? attachmentName = json['attachmentName'] as String? ??
        json['fileName'] as String? ??
        json['attachmentFileName'] as String?;

    if ((attachmentName == null || attachmentName.isEmpty) &&
        attachmentUrl != null &&
        attachmentUrl.isNotEmpty) {
      final uri = Uri.tryParse(attachmentUrl);
      if (uri != null && uri.pathSegments.isNotEmpty) {
        attachmentName = uri.pathSegments.last;
      }
    }

    // 12. Start Date
    String startDate = '-';
    final rawStart = json['startDate'] ??
        projectMap?['startDate'] ??
        json['expectedStartDate'] ??
        projectMap?['expectedStartDate'];
    if (rawStart != null && rawStart.toString().trim().isNotEmpty) {
      final str = rawStart.toString();
      startDate = str.contains('T') ? str.split('T').first : str;
    }

    // 13. Completion Date
    String completionDate = '-';
    final rawEnd = json['completionDate'] ??
        projectMap?['completionDate'] ??
        json['expectedEndDate'] ??
        projectMap?['expectedEndDate'] ??
        json['endDate'];
    if (rawEnd != null && rawEnd.toString().trim().isNotEmpty) {
      final str = rawEnd.toString();
      completionDate = str.contains('T') ? str.split('T').first : str;
    }

    return MyBidModel(
      id: json['id']?.toString() ?? json['bidId']?.toString() ?? '',
      projectId: projectId,
      title: title,
      location: location,
      image: image,
      status: status,
      statusColorHex: statusColorHex,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      yourBid: yourBid,
      duration: duration,
      submittedDate: submittedDate,
      rejectionReason:
          actions?['text'] as String? ?? json['rejectionReason'] as String?,
      landArea: landArea,
      floors: floors,
      finishingLevel: finishingLevel,
      description: description,
      proposal: proposal,
      attachmentUrl: attachmentUrl,
      attachmentName: attachmentName,
      startDate: startDate,
      completionDate: completionDate,
      images: images,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'title': title,
      'location': location,
      'image': image,
      'status': status,
      'statusColor': statusColorHex,
      'isBookmarked': isBookmarked,
      'stats': {
        'yourBid': yourBid,
        'duration': duration,
        'submitted': submittedDate,
      },
      'rejectionReason': rejectionReason,
      'landArea': landArea,
      'floors': floors,
      'finishingLevel': finishingLevel,
      'description': description,
      'proposal': proposal,
      'attachmentUrl': attachmentUrl,
      'attachmentName': attachmentName,
      'startDate': startDate,
      'completionDate': completionDate,
      'images': images,
    };
  }

  MyBidModel copyWith({
    String? id,
    String? projectId,
    String? title,
    String? location,
    String? image,
    String? status,
    String? statusColorHex,
    bool? isBookmarked,
    String? yourBid,
    String? duration,
    String? submittedDate,
    String? rejectionReason,
    String? landArea,
    String? floors,
    String? finishingLevel,
    String? description,
    String? proposal,
    String? attachmentUrl,
    String? attachmentName,
    String? startDate,
    String? completionDate,
    List<String>? images,
  }) {
    return MyBidModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      location: location ?? this.location,
      image: image ?? this.image,
      status: status ?? this.status,
      statusColorHex: statusColorHex ?? this.statusColorHex,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      yourBid: yourBid ?? this.yourBid,
      duration: duration ?? this.duration,
      submittedDate: submittedDate ?? this.submittedDate,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      landArea: landArea ?? this.landArea,
      floors: floors ?? this.floors,
      finishingLevel: finishingLevel ?? this.finishingLevel,
      description: description ?? this.description,
      proposal: proposal ?? this.proposal,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachmentName: attachmentName ?? this.attachmentName,
      startDate: startDate ?? this.startDate,
      completionDate: completionDate ?? this.completionDate,
      images: images ?? this.images,
    );
  }
}
