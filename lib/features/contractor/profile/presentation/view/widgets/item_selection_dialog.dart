import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class ItemSelectionDialog extends StatefulWidget {
  final String title;
  final String hintText;
  final List<String> allItems;
  final List<String> currentSelected;

  const ItemSelectionDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.allItems,
    this.currentSelected = const [],
  });

  static Future<String?> show(
    BuildContext context, {
    required String title,
    required String hintText,
    required List<String> allItems,
    List<String> currentSelected = const [],
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) => ItemSelectionDialog(
        title: title,
        hintText: hintText,
        allItems: allItems,
        currentSelected: currentSelected,
      ),
    );
  }

  @override
  State<ItemSelectionDialog> createState() => _ItemSelectionDialogState();
}

class _ItemSelectionDialogState extends State<ItemSelectionDialog> {
  final TextEditingController _searchController = TextEditingController();
  late List<String> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.allItems
        .where((item) => !widget.currentSelected.contains(item))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      final q = query.trim().toLowerCase();
      _filteredItems = widget.allItems
          .where((item) =>
              !widget.currentSelected.contains(item) &&
              item.toLowerCase().contains(q))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim();
    final canAddCustom = query.isNotEmpty &&
        !widget.currentSelected.any(
            (item) => item.toLowerCase() == query.toLowerCase());

    return Dialog(
      backgroundColor: AppColors.white100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1D1D1F),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                  iconSize: 20.r,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: const Color(0xFF8E8E93),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            // Search TextField
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8FA),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFE5E5EA),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                autofocus: true,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF1D1D1F),
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF8E8E93),
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 20.r,
                    color: AppColors.primary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Suggestions List
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 220.h),
              child: _filteredItems.isEmpty && !canAddCustom
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          'No matching items found',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF8E8E93),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredItems.length + (canAddCustom && !_filteredItems.contains(query) ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (canAddCustom && !_filteredItems.contains(query) && index == 0) {
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
                            leading: Icon(
                              Icons.add_circle_outline_rounded,
                              color: AppColors.primary,
                              size: 20.r,
                            ),
                            title: Text(
                              'Add "$query"',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            onTap: () => Navigator.of(context).pop(query),
                          );
                        }

                        final itemIndex = canAddCustom && !_filteredItems.contains(query)
                            ? index - 1
                            : index;
                        final item = _filteredItems[itemIndex];

                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
                          title: Text(
                            item,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFF1D1D1F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 13.r,
                            color: const Color(0xFFC7C7CC),
                          ),
                          onTap: () => Navigator.of(context).pop(item),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
