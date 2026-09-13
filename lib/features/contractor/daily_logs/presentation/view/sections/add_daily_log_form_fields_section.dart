import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class AddDailyLogFormFieldsSection extends StatefulWidget {
  final TextEditingController workSummaryController;
  final TextEditingController equipmentController;
  final TextEditingController workersController;

  const AddDailyLogFormFieldsSection({
    super.key,
    required this.workSummaryController,
    required this.equipmentController,
    required this.workersController,
  });

  @override
  State<AddDailyLogFormFieldsSection> createState() =>
      _AddDailyLogFormFieldsSectionState();
}

class _AddDailyLogFormFieldsSectionState
    extends State<AddDailyLogFormFieldsSection> {
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _charCount = widget.workSummaryController.text.length;
    widget.workSummaryController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {
        _charCount = widget.workSummaryController.text.length;
      });
    }
  }

  @override
  void dispose() {
    widget.workSummaryController.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Work Summary Section
        _buildFieldLabel('Work Summary'),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: const Color(0xFFE5E5EA),
              width: 1.w,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: widget.workSummaryController,
                maxLines: 4,
                maxLength: 500,
                buildCounter: (_, {required currentLength, required isFocused, maxLength}) =>
                    const SizedBox.shrink(),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF1D1D1F),
                ),
                decoration: InputDecoration(
                  hintText:
                      "Describe the day's primary activities and progress...",
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFFC7C7CC),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '$_charCount/500',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF8E8E93),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 18.h),

        // 2. Equipment Used Section
        _buildFieldLabel('Equipment Used'),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: const Color(0xFFE5E5EA),
              width: 1.w,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: TextField(
            controller: widget.equipmentController,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF1D1D1F),
            ),
            decoration: InputDecoration(
              hintText: 'e.g., Excavator, Crane, Concrete Mixer',
              hintStyle: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFFC7C7CC),
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),

        SizedBox(height: 18.h),

        // 3. Workers Count Section
        _buildFieldLabel('Workers Count'),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: const Color(0xFFE5E5EA),
              width: 1.w,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: TextField(
            controller: widget.workersController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF1D1D1F),
            ),
            decoration: InputDecoration(
              hintText: 'Total number of workers on site',
              hintStyle: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFFC7C7CC),
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1D1D1F),
      ),
    );
  }
}
