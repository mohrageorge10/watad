import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_request.dart';
import 'package:watad/features/dashboard/owner/feasibility/presentation/cubit/feasibility_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import '../widgets/number_selector_widget.dart';
import '../widgets/segmented_selector_widget.dart';

class FeasibilityCalculatorView extends StatefulWidget {
  const FeasibilityCalculatorView({super.key});

  @override
  State<FeasibilityCalculatorView> createState() => _FeasibilityCalculatorViewState();
}

class _FeasibilityCalculatorViewState extends State<FeasibilityCalculatorView> {
  final _formKey = GlobalKey<FormState>();
  
  final _landAreaController = TextEditingController();
  int _floorsCount = 3;
  
  String? _selectedGovernorate;
  String? _selectedCity;
  int _selectedFinishingLevel = 1;

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

  List<String> get _governorates => _egyptLocations.keys.toList();
  List<String> get _cities => _selectedGovernorate != null 
      ? _egyptLocations[_selectedGovernorate]! 
      : [];

  @override
  void dispose() {
    _landAreaController.dispose();
    super.dispose();
  }

  void _calculate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_selectedGovernorate == null || _selectedCity == null) {
        AppToast.showError(context, 'Please select governorate and city');
        return;
      }
      
      final request = FeasibilityRequest(
        landArea: double.tryParse(_landAreaController.text) ?? 0,
        floorsCount: _floorsCount,
        finishingLevel: _selectedFinishingLevel,
        governorate: _selectedGovernorate!,
        city: _selectedCity!,
        latitude: 0,
        longitude: 0,
      );
      
      context.read<FeasibilityCubit>().calculateFeasibility(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FeasibilityCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFF),
        body: SafeArea(
          child: BlocConsumer<FeasibilityCubit, FeasibilityState>(
            listener: (context, state) {
              if (state is FeasibilitySuccess) {
                context.push(
                  AppRoutes.feasibilityReport,
                  extra: state.report,
                );
              } else if (state is FeasibilityError) {
                AppToast.showError(context, state.failure.errMessage);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      SizedBox(height: 32.h),
                      
                      _buildLabel('Land Area (m²)'),
                      SizedBox(height: 12.h),
                      _ShadowedTextField(
                        controller: _landAreaController,
                        hintText: '500',
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                      SizedBox(height: 24.h),
                      
                      _buildLabel('Goverment'),
                      SizedBox(height: 12.h),
                      _ShadowedDropdown<String>(
                        value: _selectedGovernorate,
                        items: _governorates,
                        onChanged: (v) => setState(() {
                          _selectedGovernorate = v;
                          _selectedCity = null;
                        }),
                      ),
                      SizedBox(height: 24.h),
                      
                      _buildLabel('City'),
                      SizedBox(height: 12.h),
                      _ShadowedDropdown<String>(
                        value: _selectedCity,
                        items: _cities,
                        onChanged: (v) => setState(() => _selectedCity = v),
                      ),
                      SizedBox(height: 24.h),
                      
                      _buildLabel('Number of Floors'),
                      SizedBox(height: 12.h),
                      NumberSelectorWidget(
                        value: _floorsCount,
                        min: 1,
                        max: 20,
                        onChanged: (v) => setState(() => _floorsCount = v),
                      ),
                      SizedBox(height: 24.h),
                      
                      _buildLabel('Finishing Level'),
                      SizedBox(height: 12.h),
                      SegmentedSelectorWidget<int>(
                        value: _selectedFinishingLevel,
                        items: const [0, 1, 2],
                        itemTextBuilder: (v) {
                          switch (v) {
                            case 0: return 'Basic';
                            case 1: return 'Standard';
                            case 2: return 'High';
                            default: return '';
                          }
                        },
                        onChanged: (v) => setState(() => _selectedFinishingLevel = v),
                      ),
                      SizedBox(height: 48.h),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: AppElevatedButton(
                          title: 'Calculate',
                          onPressed: state is FeasibilityLoading
                              ? null
                              : () => _calculate(context),
                          isLoading: state is FeasibilityLoading,
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
            ),
          ),
          Text(
            'Feasibility Calculator',
            style: AppTextStyles.font16SemiBold.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.font14SemiBoldDark.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.grey900,
      ),
    );
  }
}

class _ShadowedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _ShadowedTextField({
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.grey500),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.grey400),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: AppColors.danger500),
          ),
        ),
      ),
    );
  }
}

class _ShadowedDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const _ShadowedDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<T>(
        initialValue: value,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e.toString()))).toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.grey900),
        style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.grey900),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
