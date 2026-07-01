part of 'auth_bloc.dart';

sealed class AuthEvent {}

class SendOtpRequested extends AuthEvent {
  final String phone;

  SendOtpRequested(this.phone);
}

class VerifyOtpRequested extends AuthEvent {
  final String phone;
  final String otp;

  VerifyOtpRequested({required this.phone, required this.otp});
}

class SetPinRequested extends AuthEvent {
  final String pin;

  SetPinRequested(this.pin);
}
