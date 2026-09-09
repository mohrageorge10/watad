import 'package:equatable/equatable.dart';

class ContractorProfile extends Equatable {
  final String id;
  final String name;
  final String coveredGovernorates;
  final double rating;
  final int matchPercentage;
  final String imageUrl;
  final int reviewsCount;
  final String specialization;
  final int yearsOfExperience;

  const ContractorProfile({
    required this.id,
    required this.name,
    required this.coveredGovernorates,
    required this.rating,
    required this.matchPercentage,
    required this.imageUrl,
    required this.reviewsCount,
    required this.specialization,
    required this.yearsOfExperience,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        coveredGovernorates,
        rating,
        matchPercentage,
        imageUrl,
        reviewsCount,
        specialization,
        yearsOfExperience,
      ];
}
