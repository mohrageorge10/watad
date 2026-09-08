class PortfolioProjectItemModel {
  final String id;
  final String title;
  final String location;
  final String price;
  final String date;
  final String image;
  final String badgeText;
  final String badgeType; // 'success' or 'pending'

  const PortfolioProjectItemModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.date,
    required this.image,
    required this.badgeText,
    required this.badgeType,
  });

  bool get isSuccessBadge => badgeType.toLowerCase() == 'success';

  factory PortfolioProjectItemModel.fromJson(Map<String, dynamic> json) {
    final badgeMap = json['badge'] as Map<String, dynamic>?;
    return PortfolioProjectItemModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
      price: json['price'] as String? ?? '',
      date: json['date'] as String? ?? '',
      image: json['image'] as String? ?? '',
      badgeText: badgeMap?['text'] as String? ?? (json['badgeText'] as String? ?? ''),
      badgeType: badgeMap?['type'] as String? ?? (json['badgeType'] as String? ?? 'success'),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'price': price,
        'date': date,
        'image': image,
        'badge': {
          'text': badgeText,
          'type': badgeType,
        },
      };
}
