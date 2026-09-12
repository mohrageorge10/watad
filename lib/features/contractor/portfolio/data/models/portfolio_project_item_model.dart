class PortfolioProjectItemModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String price;
  final String date;
  final String image;
  final List<String> mediaUrls;
  final double? projectCost;
  final String badgeText;
  final String badgeType; // 'success' or 'pending'

  const PortfolioProjectItemModel({
    required this.id,
    required this.title,
    this.description = '',
    required this.location,
    required this.price,
    required this.date,
    required this.image,
    this.mediaUrls = const [],
    this.projectCost,
    required this.badgeText,
    required this.badgeType,
  });

  bool get isSuccessBadge => badgeType.toLowerCase() == 'success';

  List<String> get allImages {
    if (mediaUrls.isNotEmpty) return mediaUrls;
    if (image.isNotEmpty) return [image];
    return const [];
  }

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

    // Parse mediaUrls
    final rawMedia = json['mediaUrls'] ?? json['images'] ?? json['media'];
    List<String> parsedMediaUrls = [];
    if (rawMedia is List) {
      parsedMediaUrls = rawMedia.map((item) => item.toString()).toList();
    }

    final singleImage = json['image'] as String? ??
        json['imageUrl'] as String? ??
        json['coverImage'] as String? ??
        (parsedMediaUrls.isNotEmpty ? parsedMediaUrls.first : '');

    // Parse cost
    final dynamic rawCost = json['projectCost'] ?? json['cost'] ?? json['budget'] ?? json['price'];
    double? cost;
    if (rawCost is num) {
      cost = rawCost.toDouble();
    } else if (rawCost is String) {
      cost = double.tryParse(rawCost.replaceAll(RegExp(r'[^0-9.]'), ''));
    }

    final rawDate = json['completionDate'] as String? ??
        json['date'] as String? ??
        json['createdAt'] as String? ??
        '';

    return PortfolioProjectItemModel(
      id: json['id']?.toString() ?? json['projectId']?.toString() ?? '',
      title: json['title'] as String? ??
          json['projectName'] as String? ??
          json['name'] as String? ??
          '',
      description: json['description'] as String? ??
          json['technicalDetails'] as String? ??
          json['details'] as String? ??
          '',
      location: json['location'] as String? ??
          json['city'] as String? ??
          json['address'] as String? ??
          '',
      price: cost != null
          ? 'EGP ${cost.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
          : (json['price']?.toString() ?? ''),
      date: rawDate,
      image: singleImage,
      mediaUrls: parsedMediaUrls.isNotEmpty
          ? parsedMediaUrls
          : (singleImage.isNotEmpty ? [singleImage] : const []),
      projectCost: cost,
      badgeText: badgeText.isNotEmpty ? badgeText : 'Completed',
      badgeType: badgeType,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'location': location,
        'price': price,
        'date': date,
        'image': image,
        'mediaUrls': mediaUrls,
        'projectCost': projectCost,
        'badge': {
          'text': badgeText,
          'type': badgeType,
        },
      };

  Map<String, dynamic> toApiJson() => {
        'title': title,
        'description': description,
        'location': location,
        'projectCost': projectCost ?? 0.0,
        'completionDate': date,
        'mediaUrls': allImages,
      };

  PortfolioProjectItemModel copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    String? price,
    String? date,
    String? image,
    List<String>? mediaUrls,
    double? projectCost,
    String? badgeText,
    String? badgeType,
  }) {
    return PortfolioProjectItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      price: price ?? this.price,
      date: date ?? this.date,
      image: image ?? this.image,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      projectCost: projectCost ?? this.projectCost,
      badgeText: badgeText ?? this.badgeText,
      badgeType: badgeType ?? this.badgeType,
    );
  }
}

typedef PortfolioItemModel = PortfolioProjectItemModel;
