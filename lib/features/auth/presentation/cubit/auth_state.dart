import 'package:equatable/equatable.dart';
import 'package:watad/features/auth/domain/entities/auth_response_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccessState extends AuthState {
  final AuthResponseEntity response;
  const LoginSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class RegisterSuccessState extends AuthState {
  final AuthResponseEntity response;
  const RegisterSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class ConfirmEmailSuccessState extends AuthState {
  final AuthResponseEntity response;
  const ConfirmEmailSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class ResendOtpSuccessState extends AuthState {
  final String message;
  const ResendOtpSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class ForgotPasswordSuccessState extends AuthState {
  final String message;
  const ForgotPasswordSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class VerifyOtpSuccessState extends AuthState {
  final String resetToken;
  final String message;
  const VerifyOtpSuccessState({required this.resetToken, required this.message});

  @override
  List<Object?> get props => [resetToken, message];
}

class ResetPasswordSuccessState extends AuthState {
  final String message;
  const ResetPasswordSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class SocialLoginSuccessState extends AuthState {
  final AuthResponseEntity response;
  const SocialLoginSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class AuthErrorState extends AuthState {
  final String message;
  const AuthErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
