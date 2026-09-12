import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/profile/data/constants/profile_constants.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/custom_chip_widget.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/dashed_button_widget.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/item_selection_dialog.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/section_card_widget.dart';

class SpecializationSection extends StatelessWidget {
  final ContractorProfileEntity profile;
  final ValueChanged<String>? onRemoveSpecialization;
  final ValueChanged<String>? onAddSpecialization;

  const SpecializationSection({
    super.key,
    required this.profile,
    this.onRemoveSpecialization,
    this.onAddSpecialization,
  });

  Future<void> _handleAddTap(BuildContext context) async {
    final result = await ItemSelectionDialog.show(
      context,
      title: 'Add Specialization',
      hintText: 'Search or enter specialization...',
      allItems: ProfileConstants.specializations,
      currentSelected: profile.specializations,
    );

    if (result != null && result.trim().isNotEmpty) {
      onAddSpecialization?.call(result.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      icon: Icons.work_outline_rounded,
      title: 'Specialization',
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ...profile.specializations.map(
            (specialization) => CustomChipWidget(
              label: specialization,
              hasCloseIcon: true,
              onCloseTap: () => onRemoveSpecialization?.call(specialization),
            ),
          ),
          DashedButtonWidget(
            text: '+ Add',
            onTap: () => _handleAddTap(context),
          ),
        ],
      ),
    );
  }
}
