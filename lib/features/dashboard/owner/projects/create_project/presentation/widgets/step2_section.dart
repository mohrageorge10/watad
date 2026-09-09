import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/cubit/create_project_cubit.dart';

class Step2Section extends StatefulWidget {
  const Step2Section({super.key});

  @override
  State<Step2Section> createState() => _Step2SectionState();
}

class _Step2SectionState extends State<Step2Section> {
  final Map<String, List<String>> _egyptLocations = {
    'Cairo': ['Nasr City', 'Maadi', 'Heliopolis', 'New Cairo', 'Zamalek', 'Shoubra'],
    'Giza': ['6th of October', 'Dokki', 'Mohandeseen', 'Sheikh Zayed', 'Haram', 'Faisal'],
    'Alexandria': ['Smouha', 'Sidi Gaber', 'Borg El Arab', 'Montaza', 'Miami', 'Glym'],
    'Dakahlia': ['Mansoura', 'Talkha', 'Mit Ghamr', 'Dekernes', 'Aga'],
    'Red Sea': ['Hurghada', 'Safaga', 'Marsa Alam', 'El Qusiar'],
    'Sharkia': ['Zagazig', '10th of Ramadan', 'Belbeis', 'Minya El Qamh'],
    'Qalyubia': ['Banha', 'Qalyub', 'Shubra El Kheima', 'Obour'],
    'Gharbia': ['Tanta', 'El Mahalla El Kubra', 'Kafr El Zayat', 'Zifta'],
    'Monufia': ['Shibin El Kom', 'Menouf', 'Sadat City', 'Ashmun'],
    'Sharqia': ['Zagazig', '10th of Ramadan', 'Belbeis'],
    'Beheira': ['Damanhour', 'Kafr El Dawwar', 'Rashid'],
    'Kafr El Sheikh': ['Kafr El Sheikh', 'Desouk', 'Baltim'],
    'Damietta': ['Damietta', 'New Damietta', 'Ras El Bar'],
    'Port Said': ['Port Said', 'Port Fouad'],
    'Ismailia': ['Ismailia', 'Fayed', 'Abu Suweir'],
    'Suez': ['Suez', 'Al Arbaeen', 'El Ganayen'],
    'South Sinai': ['Sharm El Sheikh', 'Dahab', 'Nuweiba', 'Taba'],
    'North Sinai': ['Arish', 'Bir El Abd', 'Sheikh Zuweid'],
    'Matrouh': ['Marsa Matrouh', 'Sidi Barrani', 'Siwa'],
    'Luxor': ['Luxor City', 'Armant', 'Esna'],
    'Aswan': ['Aswan City', 'Kom Ombo', 'Abu Simbel'],
    'Assiut': ['Assiut City', 'Sohag', 'Manfalut'],
    'Sohag': ['Sohag City', 'Akhmim', 'Girga'],
    'Qena': ['Qena City', 'Luxor', 'Hurghada'],
    'Minya': ['Minya City', 'Mallawi', 'Maghagha'],
    'Beni Suef': ['Beni Suef City', 'El Fashn', 'Nasser'],
    'Fayoum': ['Fayoum City', 'Ibsheway', 'Tamiya'],
    'New Valley': ['Kharga', 'Dakhla', 'Farafra'],
  };

  String? _selectedGov;
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    final state = context.read<CreateProjectCubit>().state;
    _selectedGov = state.governorate.isNotEmpty ? state.governorate : null;
    _selectedCity = state.city.isNotEmpty ? state.city : null;
  }

  List<String> get _cities =>
      _selectedGov != null ? (_egyptLocations[_selectedGov] ?? []) : [];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProjectCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Text("Governorate", style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.grey900)),
          SizedBox(height: 8.h),
          _buildDropdown(
            value: _selectedGov,
            hint: 'Select Governorate',
            items: _egyptLocations.keys.toList(),
            onChanged: (val) {
              setState(() {
                _selectedGov = val;
                _selectedCity = null;
              });
              cubit.updateData(governorate: val ?? '', city: '');
            },
          ),
          SizedBox(height: 20.h),
          Text("City", style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.grey900)),
          SizedBox(height: 8.h),
          _buildDropdown(
            value: _selectedCity,
            hint: 'Select City',
            items: _cities,
            onChanged: (val) {
              setState(() => _selectedCity = val);
              cubit.updateData(city: val ?? '');
            },
          ),
          SizedBox(height: 20.h),

          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => cubit.previousStep(),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text('Back',
                      style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppElevatedButton(
                  title: 'Next',
                  borderRadius: 30,
                  onPressed: () {
                    if (_selectedGov == null || _selectedCity == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select governorate and city')),
                      );
                      return;
                    }
                    cubit.nextStep();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint,
              style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey400)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.grey600),
          style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey900),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
