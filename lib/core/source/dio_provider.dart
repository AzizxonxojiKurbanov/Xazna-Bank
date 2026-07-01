import 'package:dio/dio.dart';
import 'package:xazna_bank/core/source/constants/api_constants.dart';

class DioProvider {
  DioProvider._();

  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(seconds: 20),
        sendTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 20),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
  }
}
