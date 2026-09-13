import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/bids/presentation/view/sections/bid_details_content_section.dart';
import 'package:watad/features/contractor/bids/presentation/view/sections/bid_details_header_section.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_details_entity.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';
import 'package:watad/features/contractor/marketplace/domain/usecases/get_marketplace_project_details_usecase.dart';
import 'package:watad/features/contractor/marketplace/domain/usecases/get_marketplace_projects_usecase.dart';

class BidDetailsScreen extends StatefulWidget {
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
  final VoidCallback? onViewContractTap;

  const BidDetailsScreen({
    super.key,
    this.bid,
    this.title = 'Project Details',
    this.location = 'Egypt',
    this.status = 'Pending Review',
    this.estimatedBudget = '-',
    this.expectedDuration = '-',
    this.startDate = '-',
    this.completionDate = '-',
    this.landArea = '-',
    this.floors = '-',
    this.finishingLevel = '-',
    this.description = 'No description provided.',
    this.images,
    this.isBookmarked = false,
    this.onBackTap,
    this.onSettingsTap,
    this.onViewContractTap,
  });

  @override
  State<BidDetailsScreen> createState() => _BidDetailsScreenState();
}

class _BidDetailsScreenState extends State<BidDetailsScreen> {
  late String _title;
  late String _location;
  late String _status;
  late String _estimatedBudget;
  late String _expectedDuration;
  late String _startDate;
  late String _completionDate;
  late String _landArea;
  late String _floors;
  late String _finishingLevel;
  late String _description;
  late List<String> _images;
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    final bid = widget.bid;
    _title = (bid != null && bid.title.isNotEmpty) ? bid.title : widget.title;
    _location = (bid != null && bid.location.isNotEmpty && bid.location != '-')
        ? bid.location
        : widget.location;
    _status = (bid != null && bid.status.isNotEmpty) ? bid.status : widget.status;
    _estimatedBudget = (bid != null && bid.yourBid.isNotEmpty && bid.yourBid != '-')
        ? bid.yourBid
        : widget.estimatedBudget;
    _expectedDuration =
        (bid != null && bid.duration.isNotEmpty && bid.duration != '-')
            ? bid.duration
            : widget.expectedDuration;
    _startDate = (bid != null && bid.startDate.isNotEmpty && bid.startDate != '-')
        ? bid.startDate
        : widget.startDate;
    _completionDate =
        (bid != null && bid.completionDate.isNotEmpty && bid.completionDate != '-')
            ? bid.completionDate
            : widget.completionDate;
    _landArea = (bid != null && bid.landArea.isNotEmpty && bid.landArea != '-')
        ? bid.landArea
        : widget.landArea;
    _floors = (bid != null && bid.floors.isNotEmpty && bid.floors != '-')
        ? bid.floors
        : widget.floors;
    _finishingLevel =
        (bid != null && bid.finishingLevel.isNotEmpty && bid.finishingLevel != '-')
            ? bid.finishingLevel
            : widget.finishingLevel;
    _description =
        (bid != null && bid.description.isNotEmpty && bid.description != '-')
            ? bid.description
            : widget.description;
    _isBookmarked = bid?.isBookmarked ?? widget.isBookmarked;

    if (widget.images != null && widget.images!.isNotEmpty) {
      _images = widget.images!;
    } else if (bid != null && bid.images.isNotEmpty) {
      _images = bid.images;
    } else if (bid != null && bid.image.isNotEmpty) {
      _images = [bid.image];
    } else {
      _images = const [
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80',
      ];
    }

    _fetchFullProjectDetails();
  }

  Future<void> _fetchFullProjectDetails() async {
    final projId = widget.bid?.projectId ?? '';
    final searchTitle = _title.toLowerCase().trim();

    // 1. If we have a direct project ID, try fetching full details
    if (projId.isNotEmpty && sl.isRegistered<GetMarketplaceProjectDetailsUseCase>()) {
      final res = await sl<GetMarketplaceProjectDetailsUseCase>()(projId);
      res.fold(
        (details) {
          if (mounted) _applyProjectDetails(details);
        },
        (_) {},
      );
      return;
    }

    // 2. Otherwise cross-reference Marketplace projects list
    if (sl.isRegistered<GetMarketplaceProjectsUseCase>()) {
      final mpRes = await sl<GetMarketplaceProjectsUseCase>()();
      mpRes.fold(
        (projects) async {
          final matched = projects.where((p) =>
              p.id == projId ||
              p.title.toLowerCase().trim() == searchTitle).firstOrNull;

          if (matched != null && mounted) {
            _applyMarketplaceProject(matched);

            // Also try fetching deeper specs
            if (sl.isRegistered<GetMarketplaceProjectDetailsUseCase>()) {
              final detRes =
                  await sl<GetMarketplaceProjectDetailsUseCase>()(matched.id);
              detRes.fold(
                (details) {
                  if (mounted) _applyProjectDetails(details);
                },
                (_) {},
              );
            }
          }
        },
        (_) {},
      );
    }
  }

  void _applyMarketplaceProject(MarketplaceProjectEntity p) {
    setState(() {
      if (_location == 'Egypt' || _location == '-' || _location.isEmpty) {
        _location = p.location;
      }
      if (_landArea == '-' || _landArea.isEmpty) {
        _landArea = p.specs.land;
      }
      if (_floors == '-' || _floors.isEmpty) {
        _floors = p.specs.scope;
      }
      if (_description == 'No description provided.' ||
          _description == '-' ||
          _description.isEmpty) {
        _description =
            'Project in ${p.location} with budget of ${p.budgetValue}. Land: ${p.specs.land}, Scope: ${p.specs.scope}.';
      }
      if (_startDate == '-' || _startDate.isEmpty) {
        _startDate = p.timePosted.isNotEmpty ? p.timePosted : 'Immediate';
      }
      if (_completionDate == '-' || _completionDate.isEmpty) {
        _completionDate = 'TBD';
      }
      if ((_images.isEmpty || _images.first.contains('unsplash')) &&
          p.image.isNotEmpty) {
        _images = [p.image];
      }
    });
  }

  void _applyProjectDetails(MarketplaceProjectDetailsEntity d) {
    setState(() {
      if (d.location.isNotEmpty && d.location != 'Egypt') {
        _location = d.location;
      }
      if (d.description.isNotEmpty &&
          d.description != 'No description provided.') {
        _description = d.description;
      }
      if (d.startDate.isNotEmpty && d.startDate != '-') {
        _startDate = d.startDate;
      }
      if (d.completionDate.isNotEmpty && d.completionDate != '-') {
        _completionDate = d.completionDate;
      }
      for (final spec in d.specs) {
        final lbl = spec.label.toLowerCase();
        if (lbl.contains('land') || lbl.contains('size') || lbl.contains('area')) {
          _landArea = spec.value;
        } else if (lbl.contains('floor') || lbl.contains('scope')) {
          _floors = spec.value;
        } else if (lbl.contains('finish')) {
          _finishingLevel = spec.value;
        }
      }
      if (d.images.isNotEmpty) {
        _images = d.images;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. Header Section
            BidDetailsHeaderSection(
              title: 'Bid Details',
              onBackTap: widget.onBackTap,
              onSettingsTap: widget.onSettingsTap,
            ),

            // 2. Content Section
            BidDetailsContentSection(
              bidId: widget.bid?.id,
              title: _title,
              location: _location,
              status: _status,
              estimatedBudget: _estimatedBudget,
              expectedDuration: _expectedDuration,
              startDate: _startDate,
              completionDate: _completionDate,
              landArea: _landArea,
              floors: _floors,
              finishingLevel: _finishingLevel,
              description: _description,
              images: _images,
              initialIsBookmarked: _isBookmarked,
              onViewContractTap: widget.onViewContractTap ??
                  () {
                    context.pushNamed(
                      AppRoutes.contractPreview,
                      extra: {
                        'contractId': widget.bid?.id,
                        'bidId': widget.bid?.id,
                      },
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }
}
