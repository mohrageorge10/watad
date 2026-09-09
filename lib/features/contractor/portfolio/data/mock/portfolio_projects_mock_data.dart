import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';

class PortfolioProjectsMockData {
  PortfolioProjectsMockData._();

  static const List<PortfolioProjectItemModel> projects = [
    PortfolioProjectItemModel(
      id: 'proj_1',
      image: 'https://images.unsplash.com/photo-1541888946425-d0fbb186c5f8?w=400&q=80',
      title: 'Villa Al-Yasmin Construction',
      location: '6th of October, Giza',
      price: 'EGP 2,500,000',
      date: 'Completed on 15 Mar 2024',
      badgeText: 'Completed',
      badgeType: 'success',
    ),
    PortfolioProjectItemModel(
      id: 'proj_2',
      image: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&q=80',
      title: 'Residential Building - New Cairo',
      location: 'New Cairo, Cairo',
      price: 'EGP 4,200,000',
      date: 'Completed on 10 Jan 2025',
      badgeText: 'Completed',
      badgeType: 'success',
    ),
    PortfolioProjectItemModel(
      id: 'proj_3',
      image: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=400&q=80',
      title: 'Commercial Complex',
      location: 'Sheikh Zayed, Giza',
      price: 'EGP 7,800,000',
      date: 'Completed on 20 Nov 2024',
      badgeText: 'Completed',
      badgeType: 'success',
    ),
    PortfolioProjectItemModel(
      id: 'proj_4',
      image: 'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=400&q=80',
      title: 'Infrastructure Project',
      location: '6th of October, Giza',
      price: 'EGP 3,600,000',
      date: 'Completed on 28 Feb 2025',
      badgeText: 'Completed',
      badgeType: 'success',
    ),
    PortfolioProjectItemModel(
      id: 'proj_5',
      image: 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=400&q=80',
      title: 'Administrative Building',
      location: 'Nasr City, Cairo',
      price: 'EGP 5,200,000',
      date: 'Completed on 12 Aug 2024',
      badgeText: 'In Progress',
      badgeType: 'pending',
    ),
  ];
}
