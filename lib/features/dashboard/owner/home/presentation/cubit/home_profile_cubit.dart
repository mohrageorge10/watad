import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/home/domain/usecases/get_owner_profile_usecase.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_profile_state.dart';

class HomeProfileCubit extends Cubit<HomeProfileState> {
  final GetOwnerProfileUseCase getOwnerProfileUseCase;

  HomeProfileCubit(this.getOwnerProfileUseCase) : super(HomeProfileInitial());

  Future<void> fetchProfile() async {
    emit(HomeProfileLoading());
    final result = await getOwnerProfileUseCase();
    result.fold(
      (data) => emit(HomeProfileLoaded(data)),
      (failure) => emit(HomeProfileError(failure)),
    );
  }
}
