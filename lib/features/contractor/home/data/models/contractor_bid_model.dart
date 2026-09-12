import 'package:watad/features/contractor/home/domain/entities/contractor_bid_entity.dart';

class ContractorBidModel extends ContractorBidEntity {
  const ContractorBidModel({
    required super.id,
    required super.title,
    required super.location,
    required super.amount,
    required super.image,
    required super.badgeText,
    required super.badgeColorHex,
  });

  factory ContractorBidModel.fromJson(Map<String, dynamic> json) {
    final badge = json['badge'] as Map<String, dynamic>?;
    return ContractorBidModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
      amount: json['time'] as String? ?? json['amount'] as String? ?? '',
      image: json['image'] as String? ?? '',
      badgeText: badge?['text'] as String? ?? '',
      badgeColorHex: badge?['color'] as String? ?? '#009688',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'amount': amount,
      'time': amount,
      'image': image,
      'badge': {
        'text': badgeText,
        'color': badgeColorHex,
      },
    };
  }
}
