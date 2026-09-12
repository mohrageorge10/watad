import 'package:watad/features/contractor/marketplace/data/models/marketplace_project_details_model.dart';

class MockMarketplaceDetailsData {
  MockMarketplaceDetailsData._();

  static MarketplaceProjectDetailsModel getVillaProjectDetails({String? id}) {
    return MarketplaceProjectDetailsModel(
      id: id ?? 'proj_1',
      title: 'Villa Construction Project',
      status: 'Open for Bids',
      location: 'New Cairo, Cairo',
      images: const [
        // Hero villa with infinity pool (matching screenshot)
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80',
        // Thumbnail 1: Pool angle
        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400&q=80',
        // Thumbnail 2: Living room
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=80',
        // Thumbnail 3: Hallway / lobby
        'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=400&q=80',
        // Thumbnail 4: Modern kitchen / interior
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400&q=80',
        // Additional images represented by +3
        'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=400&q=80',
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=400&q=80',
        'https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?w=400&q=80',
      ],
      specs: const [
        MarketplaceSpecItemModel(
          icon: 'expand',
          label: 'Land Area',
          value: '500 m²',
        ),
        MarketplaceSpecItemModel(
          icon: 'layers',
          label: 'Floors',
          value: '2',
        ),
        MarketplaceSpecItemModel(
          icon: 'checkCircleOutline',
          label: 'Finishing Level',
          value: 'Standard',
        ),
      ],
      estimatedBudget: 'EGP 2,450,000',
      expectedDuration: '6 Months',
      startDate: 'Oct 2026',
      completionDate: 'Apr 2027',
      description:
          'A modern villa with contemporary design, integrated smart home systems, and premium finishing. Located in a prime area in New Cairo.',
      attachments: const [
        MarketplaceAttachmentModel(
          title: 'Architectural_Drawings.pdf',
          size: '4.2 MB',
          fileType: 'pdf',
        ),
        MarketplaceAttachmentModel(
          title: 'Soil_Survey_Report.pdf',
          size: '1.8 MB',
          fileType: 'pdf',
        ),
      ],
    );
  }

  static MarketplaceProjectDetailsModel getDetailsForProject(
      dynamic project) {
    final String heroImg = project.image as String? ??
        'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80';

    final List<String> allImages = [
      heroImg,
      'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400&q=80',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=80',
      'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=400&q=80',
      'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400&q=80',
      'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=400&q=80',
      'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=400&q=80',
      'https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?w=400&q=80',
    ];

    return MarketplaceProjectDetailsModel(
      id: project.id as String? ?? 'proj_1',
      title: project.title as String? ?? 'Villa Construction Project',
      status: 'Open for Bids',
      location: project.location as String? ?? 'New Cairo, Cairo',
      images: allImages,
      specs: [
        MarketplaceSpecItemModel(
          icon: 'expand',
          label: 'Land Area',
          value: project.specs != null && project.specs.land.isNotEmpty
              ? project.specs.land as String
              : '500 m²',
        ),
        const MarketplaceSpecItemModel(
          icon: 'layers',
          label: 'Floors',
          value: '2',
        ),
        const MarketplaceSpecItemModel(
          icon: 'checkCircleOutline',
          label: 'Finishing Level',
          value: 'Standard',
        ),
      ],
      estimatedBudget: project.budgetValue != null &&
              project.budgetValue.toString().isNotEmpty
          ? project.budgetValue as String
          : 'EGP 2,450,000',
      expectedDuration: '6 Months',
      startDate: 'Oct 2026',
      completionDate: 'Apr 2027',
      description:
          'A modern villa with contemporary design, integrated smart home systems, and premium finishing. Located in a prime area in ${project.location ?? 'New Cairo'}.',
      attachments: const [
        MarketplaceAttachmentModel(
          title: 'Architectural_Drawings.pdf',
          size: '4.2 MB',
          fileType: 'pdf',
        ),
        MarketplaceAttachmentModel(
          title: 'Soil_Survey_Report.pdf',
          size: '1.8 MB',
          fileType: 'pdf',
        ),
      ],
    );
  }
}
