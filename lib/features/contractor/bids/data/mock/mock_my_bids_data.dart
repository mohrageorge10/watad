import 'package:watad/features/contractor/bids/data/models/my_bid_model.dart';

class MockMyBidsData {
  static List<MyBidModel> getMockBids() {
    return [
      const MyBidModel(
        id: 'bid_1',
        title: 'Villa Construction Project',
        location: 'New Cairo, Cairo',
        image:
            'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=900&q=80',
        status: 'Pending Review',
        statusColorHex: '#FFB020',
        isBookmarked: true,
        yourBid: 'EGP 2,450,000',
        duration: '6 Months',
        submittedDate: 'Sep 08, 2026',
      ),
      const MyBidModel(
        id: 'bid_2',
        title: 'Commercial Building',
        location: 'New Cairo, Cairo',
        image:
            'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=400&q=80',
        status: 'Accepted',
        statusColorHex: '#00B368',
        isBookmarked: false,
        yourBid: 'EGP 12,000,000',
        duration: '8 Months',
        submittedDate: 'Sep 15, 2026',
      ),
      const MyBidModel(
        id: 'bid_3',
        title: 'Residential Villa',
        location: '6th of October, Giza',
        image:
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=80',
        status: 'Rejected',
        statusColorHex: '#FF3B30',
        isBookmarked: true,
        yourBid: 'EGP 1,950,000',
        duration: '7 Months',
        submittedDate: 'Aug 22, 2026',
        rejectionReason:
            'Not a suitable match for the current project requirements.',
      ),
      const MyBidModel(
        id: 'bid_4',
        title: 'Modern Office Complex',
        location: 'Sheikh Zayed, Giza',
        image:
            'https://images.unsplash.com/photo-1497366216548-37526070297c?w=400&q=80',
        status: 'Pending Review',
        statusColorHex: '#FFB020',
        isBookmarked: false,
        yourBid: 'EGP 4,200,000',
        duration: '5 Months',
        submittedDate: 'Sep 10, 2026',
      ),
      const MyBidModel(
        id: 'bid_5',
        title: 'Luxury Compound Villa',
        location: 'New Cairo, Cairo',
        image:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400&q=80',
        status: 'Accepted',
        statusColorHex: '#00B368',
        isBookmarked: false,
        yourBid: 'EGP 3,800,000',
        duration: '4 Months',
        submittedDate: 'Aug 30, 2026',
      ),
    ];
  }
}
