import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/profile/data/constants/profile_constants.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/custom_chip_widget.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/dashed_button_widget.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/item_selection_dialog.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/section_card_widget.dart';

class CoveredGovernoratesSection extends StatelessWidget {
  final ContractorProfileEntity profile;
  final ValueChanged<String>? onRemoveCity;
  final ValueChanged<String>? onAddCity;

  const CoveredGovernoratesSection({
    super.key,
    required this.profile,
    this.onRemoveCity,
    this.onAddCity,
  });

  Future<void> _handleAddCityTap(BuildContext context) async {
    final result = await ItemSelectionDialog.show(
      context,
      title: 'Add Covered Governorate',
      hintText: 'Search or enter city/governorate...',
      allItems: ProfileConstants.egyptianGovernorates,
      currentSelected: profile.coveredGovernorates,
    );

    if (result != null && result.trim().isNotEmpty) {
      onAddCity?.call(result.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      icon: Icons.location_on_outlined,
      title: 'Covered Governorates',
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ...profile.coveredGovernorates.map(
            (city) => CustomChipWidget(
              label: city,
              hasDot: true,
              hasCloseIcon: true,
              onCloseTap: () => onRemoveCity?.call(city),
            ),
          ),
          DashedButtonWidget(
            text: '+ Add City',
            onTap: () => _handleAddCityTap(context),
          ),
        ],
      ),
    );
  }
}
