part of 'create_project_cubit.dart';

enum CreateProjectStatus { initial, loading, success, error }

class CreateProjectState {
  final int currentStep;
  final CreateProjectStatus status;
  final Failure? failure;

  final String title;
  final double landArea;
  final int floorsCount;
  
  final String governorate;
  final String city;
  final double latitude;
  final double longitude;
  
  final int finishingLevel; // 0: Basic, 1: Standard, 2: High
  final double finishingCost; // EGP
  
  final DateTime expectedStartDate;
  final int expectedDurationMonths;

  final double estimatedBudget;
  
  // Extra fields for UI in step 4
  final double estimatedConstructionCost;
  final double otherCosts;

  CreateProjectState({
    required this.currentStep,
    required this.status,
    this.failure,
    required this.title,
    required this.landArea,
    required this.floorsCount,
    required this.governorate,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.finishingLevel,
    required this.finishingCost,
    required this.expectedStartDate,
    required this.expectedDurationMonths,
    required this.estimatedBudget,
    required this.estimatedConstructionCost,
    required this.otherCosts,
  });

  factory CreateProjectState.initial() {
    return CreateProjectState(
      currentStep: 1,
      status: CreateProjectStatus.initial,
      title: '',
      landArea: 0.0,
      floorsCount: 3,
      governorate: '',
      city: '',
      latitude: 0.0,
      longitude: 0.0,
      finishingLevel: 1, // Standard by default
      finishingCost: 0.0,
      expectedStartDate: DateTime.now(),
      expectedDurationMonths: 12,
      estimatedBudget: 0.0,
      estimatedConstructionCost: 0.0,
      otherCosts: 0.0,
    );
  }

  CreateProjectState copyWith({
    int? currentStep,
    CreateProjectStatus? status,
    Failure? failure,
    String? title,
    double? landArea,
    int? floorsCount,
    String? governorate,
    String? city,
    double? latitude,
    double? longitude,
    int? finishingLevel,
    double? finishingCost,
    DateTime? expectedStartDate,
    int? expectedDurationMonths,
    double? estimatedBudget,
    double? estimatedConstructionCost,
    double? otherCosts,
  }) {
    return CreateProjectState(
      currentStep: currentStep ?? this.currentStep,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      title: title ?? this.title,
      landArea: landArea ?? this.landArea,
      floorsCount: floorsCount ?? this.floorsCount,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      finishingLevel: finishingLevel ?? this.finishingLevel,
      finishingCost: finishingCost ?? this.finishingCost,
      expectedStartDate: expectedStartDate ?? this.expectedStartDate,
      expectedDurationMonths: expectedDurationMonths ?? this.expectedDurationMonths,
      estimatedBudget: estimatedBudget ?? this.estimatedBudget,
      estimatedConstructionCost: estimatedConstructionCost ?? this.estimatedConstructionCost,
      otherCosts: otherCosts ?? this.otherCosts,
    );
  }
}
