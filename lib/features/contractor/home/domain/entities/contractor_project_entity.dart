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
  final String ownerName;
  final String landArea;
  final String floors;
  final String contractValue;
  final String contractedDate;
  final String? contractId;
  final String? projectId;

  const ContractorProjectEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.time,
    required this.image,
    required this.badgeText,
    required this.badgeColorHex,
    this.progress,
    this.ownerName = 'Ahmed Al-Masry',
    this.landArea = '1,200 m²',
    this.floors = '2 Floors',
    this.contractValue = 'EGP 2,450,000',
    this.contractedDate = 'Sep 08, 2026',
    this.contractId,
    this.projectId,
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
        ownerName,
        landArea,
        floors,
        contractValue,
        contractedDate,
        contractId,
        projectId,
      ];
}
