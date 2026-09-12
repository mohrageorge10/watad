import 'package:equatable/equatable.dart';

class ContractorBidEntity extends Equatable {
  final String id;
  final String title;
  final String location;
  final String amount;
  final String image;
  final String badgeText;
  final String badgeColorHex;

  const ContractorBidEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.amount,
    required this.image,
    required this.badgeText,
    required this.badgeColorHex,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        amount,
        image,
        badgeText,
        badgeColorHex,
      ];
}
