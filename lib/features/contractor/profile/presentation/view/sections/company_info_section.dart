import 'package:flutter/material.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/key_value_row_widget.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/section_card_widget.dart';

class CompanyInfoSection extends StatelessWidget {
  final ContractorProfileEntity profile;

  const CompanyInfoSection({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      icon: Icons.apartment_rounded,
      title: 'Company Information',
      child: Column(
        children: [
          KeyValueRowWidget(
            label: 'Company Name',
            value: profile.companyName,
          ),
          KeyValueRowWidget(
            label: 'Commercial Register',
            value: profile.commercialRegister,
          ),
          KeyValueRowWidget(
            label: 'Tax Card',
            value: profile.taxCard,
          ),
        ],
      ),
    );
  }
}
