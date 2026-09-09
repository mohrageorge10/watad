import 'package:equatable/equatable.dart';

class MyBidEntity extends Equatable {
  final String id;
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

  const MyBidEntity({
    required this.id,
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
  });

  @override
  List<Object?> get props => [
        id,
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
      ];
}
