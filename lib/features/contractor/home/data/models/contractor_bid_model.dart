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

    final title = json['projectTitle'] as String? ??
        json['title'] as String? ??
        json['projectName'] as String? ??
        'Project Bid';

    String location = json['location'] as String? ?? '';
    if (location.isEmpty) {
      final city = json['city'] as String?;
      final gov = json['governorate'] as String?;
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

    String amount = json['time'] as String? ?? json['amount'] as String? ?? '';
    if (amount.isEmpty) {
      final rawCost = json['proposedCost'] ?? json['cost'] ?? json['amount'];
      if (rawCost != null) {
        final num? val = num.tryParse(rawCost.toString());
        amount = val != null ? 'EGP ${val.toStringAsFixed(0)}' : 'EGP $rawCost';
      }
    }

    String image = json['image'] as String? ??
        json['projectPhoto'] as String? ??
        json['imageUrl'] as String? ??
        '';
    if (image.isEmpty && json['photos'] is List && (json['photos'] as List).isNotEmpty) {
      image = (json['photos'] as List).first.toString();
    }
    if (image.isEmpty) {
      image = 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80';
    }

    String badgeText = badge?['text'] as String? ?? '';
    String badgeColorHex = badge?['color'] as String? ?? '#009688';
    final rawStatus = json['status'] ?? json['bidStatus'];
    if (badgeText.isEmpty && rawStatus != null) {
      if (rawStatus == 1 || rawStatus.toString().toLowerCase().contains('accept')) {
        badgeText = 'Accepted';
        badgeColorHex = '#34C759';
      } else if (rawStatus == 2 || rawStatus.toString().toLowerCase().contains('reject')) {
        badgeText = 'Rejected';
        badgeColorHex = '#FF3B30';
      } else {
        badgeText = 'Under Review';
        badgeColorHex = '#FFB020';
      }
    }

    return ContractorBidModel(
      id: json['id']?.toString() ?? json['bidId']?.toString() ?? '',
      title: title,
      location: location,
      amount: amount,
      image: image,
      badgeText: badgeText,
      badgeColorHex: badgeColorHex,
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
