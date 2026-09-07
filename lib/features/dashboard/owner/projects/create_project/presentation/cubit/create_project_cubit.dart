import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/domain/entities/create_project_request.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/domain/usecases/create_project_usecase.dart';

part 'create_project_state.dart';

class CreateProjectCubit extends Cubit<CreateProjectState> {
  final CreateProjectUseCase createProjectUseCase;

  CreateProjectCubit(this.createProjectUseCase) : super(CreateProjectState.initial());

  final PageController pageController = PageController();

  void nextStep() {
    if (state.currentStep < 4) {
      final nextStep = state.currentStep + 1;
      emit(state.copyWith(currentStep: nextStep));
      pageController.animateToPage(
        nextStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      final prevStep = state.currentStep - 1;
      emit(state.copyWith(currentStep: prevStep));
      pageController.animateToPage(
        prevStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToStep(int step) {
    if (step >= 1 && step <= 4) {
      emit(state.copyWith(currentStep: step));
      pageController.animateToPage(
        step - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void updateData({
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
    double? estimatedConstructionCost, // Used for UI in step 4
    double? otherCosts, // Used for UI in step 4
  }) {
    emit(state.copyWith(
      title: title,
      landArea: landArea,
      floorsCount: floorsCount,
      governorate: governorate,
      city: city,
      latitude: latitude,
      longitude: longitude,
      finishingLevel: finishingLevel,
      finishingCost: finishingCost,
      expectedStartDate: expectedStartDate,
      expectedDurationMonths: expectedDurationMonths,
      estimatedBudget: estimatedBudget,
      estimatedConstructionCost: estimatedConstructionCost,
      otherCosts: otherCosts,
    ));
  }

  Future<void> submitProject() async {
    emit(state.copyWith(status: CreateProjectStatus.loading));

    final request = CreateProjectRequest(
      title: state.title,
      landArea: state.landArea,
      floorsCount: state.floorsCount,
      governorate: state.governorate,
      city: state.city,
      latitude: state.latitude,
      longitude: state.longitude,
      finishingLevel: state.finishingLevel,
      estimatedBudget: state.estimatedBudget,
      expectedStartDate: state.expectedStartDate.toIso8601String(),
      expectedDurationMonths: state.expectedDurationMonths,
    );

    final result = await createProjectUseCase(request);

    result.fold(
      (_) => emit(state.copyWith(
        status: CreateProjectStatus.success,
      )),
      (failure) => emit(state.copyWith(
        status: CreateProjectStatus.error,
        failure: failure,
      )),
    );
  }
  
  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
