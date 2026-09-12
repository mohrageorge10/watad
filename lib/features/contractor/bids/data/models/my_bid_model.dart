import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';

class MyBidModel extends MyBidEntity {
  const MyBidModel({
    required super.id,
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
  });

  factory MyBidModel.fromJson(Map<String, dynamic> json) {
    final stats = json['stats'] as Map<String, dynamic>?;
    final actions = json['actions'] as Map<String, dynamic>?;

    return MyBidModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
      image: json['image'] as String? ?? '',
      status: json['status'] as String? ?? 'Pending Review',
      statusColorHex: json['statusColor'] as String? ??
          json['statusColorHex'] as String? ??
          '#FFB020',
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      yourBid: stats?['yourBid'] as String? ?? json['yourBid'] as String? ?? '',
      duration: stats?['duration'] as String? ?? json['duration'] as String? ?? '',
      submittedDate: stats?['submitted'] as String? ??
          json['submittedDate'] as String? ??
          '',
      rejectionReason: actions?['text'] as String? ??
          json['rejectionReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
    };
  }

  MyBidModel copyWith({
    String? id,
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
  }) {
    return MyBidModel(
      id: id ?? this.id,
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
    );
  }
}
