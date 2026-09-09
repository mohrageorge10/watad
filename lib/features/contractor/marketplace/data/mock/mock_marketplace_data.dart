import 'package:watad/features/contractor/marketplace/data/models/marketplace_project_model.dart';

class MockMarketplaceData {
  MockMarketplaceData._();

  static List<MarketplaceProjectModel> getProjects() {
    return const [
      MarketplaceProjectModel(
        id: 'proj_1',
        title: 'Villa Construction Project',
        location: 'New Cairo, Cairo',
        image:
            'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80',
        timePosted: '2h ago',
        isBookmarked: false,
        specs: ProjectSpecsModel(
          land: '500 m²',
          scope: '2 Floors · F...',
        ),
        budgetLabel: 'Est. Budget',
        budgetValue: 'EGP 2,450,000',
        category: 'Cairo',
      ),
      MarketplaceProjectModel(
        id: 'proj_2',
        title: 'Commercial Building',
        location: 'New Cairo, Cairo',
        image:
            'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=400&q=80',
        timePosted: '1d ago',
        isBookmarked: false,
        specs: ProjectSpecsModel(
          land: '1,200 m²',
          scope: '3 Floors · F...',
        ),
        budgetLabel: 'Est. Budget',
        budgetValue: 'EGP 12,000,000',
        category: 'Cairo',
      ),
      MarketplaceProjectModel(
        id: 'proj_3',
        title: 'Residential Villa',
        location: '6th of October, Giza',
        image:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400&q=80',
        timePosted: '3d ago',
        isBookmarked: false,
        specs: ProjectSpecsModel(
          land: '600 m²',
          scope: '1 Floor · Fir...',
        ),
        budgetLabel: 'Est. Budget',
        budgetValue: 'EGP 1,800,000',
        category: 'Giza',
      ),
      MarketplaceProjectModel(
        id: 'proj_4',
        title: 'Luxury Compound Unit',
        location: 'Sheikh Zayed, Giza',
        image:
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=80',
        timePosted: '4d ago',
        isBookmarked: true,
        specs: ProjectSpecsModel(
          land: '750 m²',
          scope: '2 Floors · F...',
        ),
        budgetLabel: 'Est. Budget',
        budgetValue: 'EGP 4,200,000',
        category: 'Giza',
      ),
      MarketplaceProjectModel(
        id: 'proj_5',
        title: 'Corporate Office Renovation',
        location: 'Maadi, Cairo',
        image:
            'https://images.unsplash.com/photo-1497366216548-37526070297c?w=400&q=80',
        timePosted: '5d ago',
        isBookmarked: false,
        specs: ProjectSpecsModel(
          land: '450 m²',
          scope: 'Open Space ·...',
        ),
        budgetLabel: 'Est. Budget',
        budgetValue: 'EGP 3,100,000',
        category: 'Cairo',
      ),
    ];
  }
}
