import 'package:watad/core/errors/failure.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/owner_profile.dart';

abstract class HomeProfileState {}

class HomeProfileInitial extends HomeProfileState {}

class HomeProfileLoading extends HomeProfileState {}

class HomeProfileLoaded extends HomeProfileState {
  final OwnerProfile profile;
  HomeProfileLoaded(this.profile);
}

class HomeProfileError extends HomeProfileState {
  final Failure failure;
  HomeProfileError(this.failure);
}
