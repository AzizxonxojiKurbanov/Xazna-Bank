part of 'auth_bloc.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SendOtpSuccess extends AuthState {
  final String phone;

  SendOtpSuccess(this.phone);
}

class VerifyOtpSuccess extends AuthState {
  final bool isNewUser;

  VerifyOtpSuccess({required this.isNewUser});
}

class SetPinSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
