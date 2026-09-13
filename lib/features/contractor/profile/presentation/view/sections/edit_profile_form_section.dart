import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/utils/app_validators.dart';
import 'package:watad/features/contractor/profile/data/constants/profile_constants.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/edit_profile_actions_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/edit_profile_chip_widget.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/item_selection_dialog.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/shadowed_text_field.dart';

class EditProfileFormSection extends StatefulWidget {
  final ContractorProfileEntity? initialProfile;
  final Future<void> Function({
    required String name,
    required String companyName,
    required String specialization,
    required String experience,
    required List<String> governorates,
    required String bio,
    String? commercialRegister,
    String? taxId,
  })? onSave;
  final VoidCallback? onCancel;

  const EditProfileFormSection({
    super.key,
    this.initialProfile,
    this.onSave,
    this.onCancel,
  });

  @override
  State<EditProfileFormSection> createState() => _EditProfileFormSectionState();
}

class _EditProfileFormSectionState extends State<EditProfileFormSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late final TextEditingController _nameController;
  late final TextEditingController _companyNameController;
  late final TextEditingController _experienceController;
  late final TextEditingController _bioController;
  late final TextEditingController _commercialRegisterController;
  late final TextEditingController _taxIdController;

  String? _selectedSpecialization;
  late List<String> _governorates;

  @override
  void initState() {
    super.initState();
    final p = widget.initialProfile;
    _nameController = TextEditingController(text: p?.name ?? '');
    _companyNameController =
        TextEditingController(text: p?.companyName ?? '');
    _experienceController = TextEditingController(
      text: (p != null && p.yearsOfExperience != '0')
          ? p.yearsOfExperience.replaceAll('+', '')
          : '',
    );
    final bioText = p?.aboutMe ?? '';
    _bioController = TextEditingController(
      text: (bioText.contains('Tap Edit Profile') ||
              bioText.contains('Specializing in'))
          ? ''
          : bioText,
    );
    _commercialRegisterController = TextEditingController(
      text: p?.commercialRegister == '-' ? '' : (p?.commercialRegister ?? ''),
    );
    _taxIdController = TextEditingController(
      text: p?.taxCard == '-' ? '' : (p?.taxCard ?? ''),
    );

    _selectedSpecialization = (p?.specializations.isNotEmpty ?? false)
        ? p!.specializations.first
        : null;

    _governorates = (p?.coveredGovernorates.isNotEmpty ?? false)
        ? List<String>.from(p!.coveredGovernorates)
        : [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyNameController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    _commercialRegisterController.dispose();
    _taxIdController.dispose();
    super.dispose();
  }

  void _removeGovernorate(String city) {
    setState(() {
      _governorates.remove(city);
    });
  }

  Future<void> _addMoreGovernorate() async {
    final result = await ItemSelectionDialog.show(
      context,
      title: 'Add Covered Governorate',
      hintText: 'Search or enter city/governorate...',
      allItems: ProfileConstants.egyptianGovernorates,
      currentSelected: _governorates,
    );

    if (result != null && result.trim().isNotEmpty) {
      setState(() {
        _governorates.add(result.trim());
      });
    }
  }

  Future<void> _handleSave() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      AppToast.showError(context, 'Please correct the highlighted fields.');
      return;
    }

    if (_governorates.isEmpty) {
      AppToast.showError(
          context, 'Please add at least one covered governorate.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.onSave != null) {
        await widget.onSave!(
          name: _nameController.text.trim(),
          companyName: _companyNameController.text.trim(),
          specialization: _selectedSpecialization ?? '',
          experience: _experienceController.text.trim().isEmpty
              ? '0'
              : '${_experienceController.text.trim()}+',
          governorates: _governorates,
          bio: _bioController.text.trim(),
          commercialRegister: _commercialRegisterController.text.trim(),
          taxId: _taxIdController.text.trim(),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Name
            ShadowedTextField(
              label: 'Full Name',
              labelColor: AppColors.primary,
              controller: _nameController,
              hintText: 'Enter your full name',
              inputType: ShadowedInputType.text,
              validator: (val) =>
                  AppValidators.validateName(val, fieldName: 'Full Name'),
            ),
            SizedBox(height: 20.h),

            // Company Name
            ShadowedTextField(
              label: 'Company Name',
              labelColor: AppColors.primary,
              controller: _companyNameController,
              hintText: 'Enter company name',
              inputType: ShadowedInputType.text,
              validator: (val) =>
                  AppValidators.validateName(val, fieldName: 'Company Name'),
            ),
            SizedBox(height: 20.h),

            // Specialization (Dropdown)
            ShadowedTextField(
              label: 'Specialization',
              labelColor: AppColors.primary,
              initialValue: _selectedSpecialization,
              hintText: 'Select Specialization',
              inputType: ShadowedInputType.dropdown,
              dropdownItems: ProfileConstants.specializations,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please select a specialization';
                }
                return null;
              },
              onDropdownChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedSpecialization = val;
                  });
                }
              },
            ),
            SizedBox(height: 20.h),

            // Years of Experience (Number)
            ShadowedTextField(
              label: 'Years of Experience',
              labelColor: AppColors.primary,
              controller: _experienceController,
              hintText: 'e.g., 5',
              inputType: ShadowedInputType.number,
              validator: AppValidators.validateExperience,
            ),
            SizedBox(height: 20.h),

            // Covered Governorates (Chips Group with live search dialog)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Covered Governorates',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    ..._governorates.map(
                      (city) => EditProfileChipWidget(
                        text: city,
                        isActive: true,
                        hasCloseIcon: true,
                        onCloseTap: () => _removeGovernorate(city),
                      ),
                    ),
                    EditProfileChipWidget(
                      text: '+ Add More',
                      isActive: false,
                      hasCloseIcon: false,
                      onTap: _addMoreGovernorate,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Bio (Multiline)
            ShadowedTextField(
              label: 'Bio',
              labelColor: AppColors.primary,
              controller: _bioController,
              hintText:
                  'Write a brief description about yourself or your company...',
              inputType: ShadowedInputType.multiline,
              maxLines: 4,
            ),
            SizedBox(height: 14.h),

            // Divider
            const Divider(
              color: Color(0xFFE5E5EA),
              thickness: 1,
            ),
            SizedBox(height: 12.h),

            // Official Details Heading
            Text(
              'Official Details (Optional)',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            // Commercial Register Number
            ShadowedTextField(
              label: 'Commercial Register Number',
              labelColor: const Color(0xFF1D1D1F),
              controller: _commercialRegisterController,
              hintText: 'e.g., 123456789',
              inputType: ShadowedInputType.text,
              validator: AppValidators.validateCommercialRegister,
            ),
            SizedBox(height: 20.h),

            // Tax ID
            ShadowedTextField(
              label: 'Tax ID',
              labelColor: const Color(0xFF1D1D1F),
              controller: _taxIdController,
              hintText: 'e.g., 987-654-321',
              inputType: ShadowedInputType.text,
              validator: AppValidators.validateTaxId,
            ),
            SizedBox(height: 24.h),

            // Action buttons: Save Changes and Cancel
            EditProfileActionsSection(
              isLoading: _isLoading,
              onSaveTap: _handleSave,
              onCancelTap: widget.onCancel ?? () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

