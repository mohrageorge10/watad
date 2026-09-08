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
    final status = json['status']?.toString();
    final badgeText = badgeMap?['text'] as String? ??
        (json['badgeText'] as String? ?? (status ?? 'Completed'));
    final badgeType = badgeMap?['type'] as String? ??
        (json['badgeType'] as String? ??
            ((status != null &&
                    (status.toLowerCase().contains('complete') ||
                        status.toLowerCase().contains('finish') ||
                        status.toLowerCase().contains('done')))
                ? 'success'
                : 'success'));

    return PortfolioProjectItemModel(
      id: json['id']?.toString() ?? json['projectId']?.toString() ?? '',
      title: json['title'] as String? ??
          json['projectName'] as String? ??
          json['name'] as String? ??
          '',
      location: json['location'] as String? ??
          json['city'] as String? ??
          json['address'] as String? ??
          '',
      price: json['price']?.toString() ??
          json['budget']?.toString() ??
          json['cost']?.toString() ??
          '',
      date: json['date'] as String? ??
          json['completionDate'] as String? ??
          json['createdAt'] as String? ??
          '',
      image: json['image'] as String? ??
          json['imageUrl'] as String? ??
          json['coverImage'] as String? ??
          '',
      badgeText: badgeText.isNotEmpty ? badgeText : 'Completed',
      badgeType: badgeType,
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

typedef PortfolioItemModel = PortfolioProjectItemModel;
