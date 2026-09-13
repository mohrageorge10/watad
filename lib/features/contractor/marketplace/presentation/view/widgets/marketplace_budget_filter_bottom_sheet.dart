import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class MarketplaceBudgetFilterBottomSheet extends StatefulWidget {
  final int? initialBudget;
  final String currentCategory;
  final List<String> availableGovernorates;
  final void Function(String category, int? minBudget) onApply;
  final VoidCallback onReset;

  const MarketplaceBudgetFilterBottomSheet({
    super.key,
    this.initialBudget,
    required this.currentCategory,
    required this.availableGovernorates,
    required this.onApply,
    required this.onReset,
  });

  static Future<void> show(
    BuildContext context, {
    int? initialBudget,
    required String currentCategory,
    required List<String> availableGovernorates,
    required void Function(String category, int? minBudget) onApply,
    required VoidCallback onReset,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => MarketplaceBudgetFilterBottomSheet(
        initialBudget: initialBudget,
        currentCategory: currentCategory,
        availableGovernorates: availableGovernorates,
        onApply: onApply,
        onReset: onReset,
      ),
    );
  }

  @override
  State<MarketplaceBudgetFilterBottomSheet> createState() =>
      _MarketplaceBudgetFilterBottomSheetState();
}

class _MarketplaceBudgetFilterBottomSheetState
    extends State<MarketplaceBudgetFilterBottomSheet> {
  static const double _maxBudgetSlider = 20000000; // 20 Million EGP

  late double _currentSliderValue;
  late TextEditingController _budgetController;
  late String _selectedCategory;

  final List<int> _quickBudgetPresets = [
    250000,
    500000,
    1000000,
    2500000,
    5000000,
    10000000,
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.currentCategory;
    final initial = (widget.initialBudget ?? 0).toDouble();
    _currentSliderValue = initial.clamp(0.0, _maxBudgetSlider);
    _budgetController = TextEditingController(
      text: initial > 0 ? initial.toInt().toString() : '',
    );
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  void _onSliderChanged(double value) {
    setState(() {
      _currentSliderValue = value;
      _budgetController.text = value > 0 ? value.toInt().toString() : '';
    });
  }

  void _onTextChanged(String text) {
    final clean = text.replaceAll(',', '').trim();
    final parsed = double.tryParse(clean);
    if (parsed != null) {
      setState(() {
        _currentSliderValue = parsed.clamp(0.0, _maxBudgetSlider);
      });
    } else if (clean.isEmpty) {
      setState(() {
        _currentSliderValue = 0.0;
      });
    }
  }

  void _setPreset(int value) {
    setState(() {
      _currentSliderValue = value.toDouble().clamp(0.0, _maxBudgetSlider);
      _budgetController.text = value.toString();
    });
  }

  String _formatNumber(num value) {
    return value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _presetLabel(int amount) {
    if (amount >= 1000000) {
      final m = amount / 1000000;
      return m % 1 == 0 ? '${m.toInt()}M' : '${m.toStringAsFixed(1)}M';
    }
    return '${(amount / 1000).toInt()}K';
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: 24.h + bottomInset,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Projects',
                  style: AppTextStyles.font18SemiBoldDark.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 22.r),
                  color: AppColors.grey500,
                  splashRadius: 20.r,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Locations Section (from Contractor Profile)
            Text(
              'Locations (From Profile)',
              style: AppTextStyles.font14SemiBoldDark,
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _buildLocationChip(label: 'All', value: 'All'),
                ...widget.availableGovernorates.map(
                  (gov) => _buildLocationChip(label: gov, value: gov),
                ),
              ],
            ),

            SizedBox(height: 24.h),
            const Divider(),
            SizedBox(height: 12.h),

            // Budget Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Minimum Budget',
                  style: AppTextStyles.font14SemiBoldDark,
                ),
                Text(
                  'From this price upwards',
                  style: AppTextStyles.font12MediumGrey.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // TextField input box
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: _currentSliderValue > 0
                      ? AppColors.primary
                      : AppColors.grey300,
                  width: 1.5,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: AppColors.primary,
                    size: 22.r,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'EGP ',
                    style: AppTextStyles.font14SemiBoldDark.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _budgetController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: AppTextStyles.font16SemiBold.copyWith(
                        color: AppColors.grey900,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter minimum price (e.g. 500000)',
                        hintStyle: AppTextStyles.font12RegularGrey,
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      ),
                      onChanged: _onTextChanged,
                    ),
                  ),
                  if (_budgetController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _budgetController.clear();
                          _currentSliderValue = 0.0;
                        });
                      },
                      child: Icon(
                        Icons.clear_rounded,
                        color: AppColors.grey400,
                        size: 20.r,
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: AppColors.grey200,
                thumbColor: AppColors.primary,
                overlayColor: AppColors.primary.withValues(alpha: 0.15),
                trackHeight: 6.h,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 10.r,
                  elevation: 3,
                ),
              ),
              child: Slider(
                value: _currentSliderValue,
                min: 0.0,
                max: _maxBudgetSlider,
                divisions: 200,
                label: _currentSliderValue > 0
                    ? 'EGP ${_formatNumber(_currentSliderValue.toInt())}'
                    : 'Any Budget',
                onChanged: _onSliderChanged,
              ),
            ),

            // Slider range labels
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('EGP 0', style: AppTextStyles.font12RegularGrey),
                  Text(
                    _currentSliderValue > 0
                        ? 'Min: EGP ${_formatNumber(_currentSliderValue.toInt())}+'
                        : 'Any price',
                    style: AppTextStyles.font12MediumGrey.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('EGP 20M+', style: AppTextStyles.font12RegularGrey),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Quick Preset Buttons
            Text(
              'Quick Presets (Min Budget)',
              style: AppTextStyles.font12MediumGrey,
            ),
            SizedBox(height: 8.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: _quickBudgetPresets.map((preset) {
                  final isSelected =
                      _currentSliderValue.toInt() == preset;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: ChoiceChip(
                      label: Text('EGP ${_presetLabel(preset)}+'),
                      selected: isSelected,
                      selectedColor: AppColors.primary.withValues(alpha: 0.15),
                      backgroundColor: AppColors.grey50,
                      labelStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.darkGrey,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.grey300,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      onSelected: (_) => _setPreset(preset),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 28.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onReset();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      side: const BorderSide(color: AppColors.grey300),
                    ),
                    child: Text(
                      'Reset',
                      style: AppTextStyles.font14SemiBoldDark.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      final min = _currentSliderValue > 0
                          ? _currentSliderValue.toInt()
                          : null;
                      widget.onApply(_selectedCategory, min);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Apply Filter',
                      style: AppTextStyles.font14SemiBoldDark.copyWith(
                        color: AppColors.white100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationChip({required String label, required String value}) {
    final isSelected = _selectedCategory == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.grey50,
      labelStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        color: isSelected ? AppColors.white100 : AppColors.grey800,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.grey300,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      onSelected: (_) {
        setState(() {
          _selectedCategory = value;
        });
      },
    );
  }
}
