import 'package:dio/dio.dart';
import 'package:xazna_bank/core/source/api_client.dart';
import 'package:xazna_bank/core/source/constants/api_constants.dart';
import 'package:xazna_bank/data/models/request/send_otp_request.dart';
import 'package:xazna_bank/data/models/request/set_pin_request.dart';
import 'package:xazna_bank/data/models/request/verify_otp_request.dart';

class AuthApiService {
  final ApiClient _apiClient;

  AuthApiService(this._apiClient);

  Future<Response<void>> sendOtp(SendOtpRequest request) {
    return _apiClient.dio.post(ApiConstants.sendOtp, data: request.toJson());
  }

  Future<Response<Map<String, dynamic>>> verifyOtp(VerifyOtpRequest request) {
    return _apiClient.dio.post<Map<String, dynamic>>(
      ApiConstants.verifyOtp,
      data: request.toJson(),
    );
  }

  Future<Response<void>> setPin(SetPinRequest request, String accessToken) {
    return _apiClient.dio.post<void>(
      ApiConstants.setPin,
      data: request.toJson(),
      options: Options(headers: {"Authorization": "Bearer $accessToken"}),
    );
  }
}
