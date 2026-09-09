import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/change_order_item.dart';
import 'change_order_list_item.dart';

class RecentChangeOrdersList extends StatelessWidget {
  final List<ChangeOrderItem> items;

  const RecentChangeOrdersList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return ChangeOrderListItem(item: items[index]);
      },
    );
  }
}
