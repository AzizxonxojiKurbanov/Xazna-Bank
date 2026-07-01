import 'package:xazna_bank/data/models/request/send_otp_request.dart';
import 'package:xazna_bank/data/models/request/set_pin_request.dart';
import 'package:xazna_bank/data/models/request/verify_otp_request.dart';
import 'package:xazna_bank/data/models/response/auth_response.dart';
import 'package:xazna_bank/data/services/auth_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final AuthApiService _api;

  AuthResponse? _authResponse;

  AuthRepository(this._api);

  String? get accessToken => _authResponse?.data.accessToken;

  Future<bool> hasSavedSession() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString(_accessTokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<void> sendOtp(String phone) async {
    final request = SendOtpRequest(phone: phone);
    await _api.sendOtp(request);
  }

  Future<AuthResponse> verifyOtp(String phone, String otp) async {
    final request = VerifyOtpRequest(phone: phone, otp: otp);
    final response = await _api.verifyOtp(request);
    final authResponse = AuthResponse.fromJson(response.data ?? {});
    _authResponse = authResponse;
    return authResponse;
  }

  Future<void> setPin(String pin) async {
    final token = accessToken;
    if (token == null || token.isEmpty) {
      throw StateError("Access token topilmadi");
    }

    final request = SetPinRequest(pin: pin);
    await _api.setPin(request, token);
    await _saveSession();
  }

  Future<void> _saveSession() async {
    final authResponse = _authResponse;
    if (authResponse == null) {
      return;
    }

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_accessTokenKey, authResponse.data.accessToken);
    await preferences.setString(
      _refreshTokenKey,
      authResponse.data.refreshToken,
    );
  }
}
