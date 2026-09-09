import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String id;
  final String reviewerName;
  final String? reviewerImage;
  final double rating;
  final String comment;
  final String date;
  final String? projectName;

  const ReviewModel({
    required this.id,
    required this.reviewerName,
    this.reviewerImage,
    required this.rating,
    required this.comment,
    required this.date,
    this.projectName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id']?.toString() ?? '',
      reviewerName: json['reviewerName'] as String? ??
          json['clientName'] as String? ??
          json['userName'] as String? ??
          'Client',
      reviewerImage: json['reviewerImage'] as String? ??
          json['avatarUrl'] as String? ??
          json['userImage'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ??
          (json['score'] as num?)?.toDouble() ??
          5.0,
      comment: json['comment'] as String? ??
          json['review'] as String? ??
          json['feedback'] as String? ??
          '',
      date: json['date'] as String? ??
          json['createdAt'] as String? ??
          'Recent',
      projectName: json['projectName'] as String? ?? json['projectTitle'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reviewerName': reviewerName,
      'reviewerImage': reviewerImage,
      'rating': rating,
      'comment': comment,
      'date': date,
      'projectName': projectName,
    };
  }

  @override
  List<Object?> get props => [
        id,
        reviewerName,
        reviewerImage,
        rating,
        comment,
        date,
        projectName,
      ];
}
