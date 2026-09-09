import 'package:flutter/material.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/bids/presentation/view/sections/bid_details_content_section.dart';
import 'package:watad/features/contractor/bids/presentation/view/sections/bid_details_header_section.dart';

class BidDetailsScreen extends StatelessWidget {
  final MyBidEntity? bid;
  final String title;
  final String location;
  final String status;
  final String estimatedBudget;
  final String expectedDuration;
  final String startDate;
  final String completionDate;
  final String landArea;
  final String floors;
  final String finishingLevel;
  final String description;
  final List<String>? images;
  final bool isBookmarked;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const BidDetailsScreen({
    super.key,
    this.bid,
    this.title = 'Villa Construction Project',
    this.location = 'New Cairo, Cairo',
    this.status = 'Pending Review',
    this.estimatedBudget = 'EGP 2,450,000',
    this.expectedDuration = '6 Months',
    this.startDate = 'Nov 2026',
    this.completionDate = 'May 2027',
    this.landArea = '500 m²',
    this.floors = '2',
    this.finishingLevel = 'Standard',
    this.description =
        'A modern villa with contemporary design, integrated smart home systems, and premium finishing. Located in a prime area in New Cairo.',
    this.images,
    this.isBookmarked = false,
    this.onBackTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    // If a MyBidEntity is passed, prefer its values
    final effectiveTitle = bid?.title ?? title;
    final effectiveLocation = bid?.location ?? location;
    final effectiveStatus = bid?.status ?? status;
    final effectiveBudget = bid?.yourBid ?? estimatedBudget;
    final effectiveDuration = bid?.duration ?? expectedDuration;
    final effectiveIsBookmarked = bid?.isBookmarked ?? isBookmarked;

    // Ensure the image shown on the card outside is always the first image inside
    final List<String> effectiveImages;
    if (images != null && images!.isNotEmpty) {
      effectiveImages = images!;
    } else if (bid != null && bid!.image.isNotEmpty) {
      const defaultPool = [
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80',
        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400&q=80',
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=80',
        'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=400&q=80',
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400&q=80',
        'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=400&q=80',
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=400&q=80',
      ];
      final others = defaultPool.where((img) => img != bid!.image).toList();
      effectiveImages = [bid!.image, ...others];
    } else {
      effectiveImages = const [
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80',
        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400&q=80',
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=80',
        'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=400&q=80',
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400&q=80',
        'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=400&q=80',
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=400&q=80',
      ];
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. Header Section
            BidDetailsHeaderSection(
              title: 'Bid Details',
              onBackTap: onBackTap,
              onSettingsTap: onSettingsTap,
            ),

            // 2. Content Section
            BidDetailsContentSection(
              title: effectiveTitle,
              location: effectiveLocation,
              status: effectiveStatus,
              estimatedBudget: effectiveBudget,
              expectedDuration: effectiveDuration,
              startDate: startDate,
              completionDate: completionDate,
              landArea: landArea,
              floors: floors,
              finishingLevel: finishingLevel,
              description: description,
              images: effectiveImages,
              initialIsBookmarked: effectiveIsBookmarked,
            ),
          ],
        ),
      ),
      // No BottomNavigationBar per explicit request: "شيل ال Bottom Navigation Bar"
    );
  }
}
