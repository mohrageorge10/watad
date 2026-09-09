import 'package:equatable/equatable.dart';

class ContractorProjectEntity extends Equatable {
  final String id;
  final String title;
  final String location;
  final String time;
  final String image;
  final String badgeText;
  final String badgeColorHex;
  final String? progress;

  const ContractorProjectEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.time,
    required this.image,
    required this.badgeText,
    required this.badgeColorHex,
    this.progress,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        time,
        image,
        badgeText,
        badgeColorHex,
        progress,
      ];
}
