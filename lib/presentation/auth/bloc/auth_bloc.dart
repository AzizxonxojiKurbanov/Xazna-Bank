import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/data/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial()) {
    on<SendOtpRequested>(_onSendOtpRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
    on<SetPinRequested>(_onSetPinRequested);
  }

  Future<void> _onSendOtpRequested(
    SendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _repository.sendOtp(event.phone);
      emit(SendOtpSuccess(event.phone));
    } on DioException catch (e) {
      emit(AuthError(_errorMessage(e, 'OTP yuborishda xatolik')));
    } catch (_) {
      emit(AuthError("Noma'lum xatolik yuz berdi"));
    }
  }

  Future<void> _onVerifyOtpRequested(
    VerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final response = await _repository.verifyOtp(event.phone, event.otp);
      emit(VerifyOtpSuccess(isNewUser: response.data.isNewUser));
    } on DioException catch (e) {
      emit(AuthError(_errorMessage(e, 'OTP kodni tasdiqlashda xatolik')));
    } catch (_) {
      emit(AuthError("Noma'lum xatolik yuz berdi"));
    }
  }

  Future<void> _onSetPinRequested(
    SetPinRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _repository.setPin(event.pin);
      emit(SetPinSuccess());
    } on DioException catch (e) {
      emit(AuthError(_errorMessage(e, 'PIN-kodni saqlashda xatolik')));
    } catch (_) {
      emit(AuthError("Noma'lum xatolik yuz berdi"));
    }
  }

  String _errorMessage(DioException e, String fallback) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final error = data['error'];
      if (error is Map<String, dynamic>) {
        return error['message'] as String? ?? fallback;
      }
    }
    return fallback;
  }
}
