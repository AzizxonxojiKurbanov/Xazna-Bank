class AuthResponse {
  final bool success;
  final AuthData data;

  AuthResponse({required this.success, required this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json["success"] == true,
      data: AuthData.fromJson(json["data"] as Map<String, dynamic>),
    );
  }
}

class AuthData {
  final String accessToken;
  final String refreshToken;
  final bool isNewUser;

  AuthData({
    required this.accessToken,
    required this.refreshToken,
    required this.isNewUser,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json["accessToken"] as String? ?? "",
      refreshToken: json["refreshToken"] as String? ?? "",
      isNewUser: json["isNewUser"] as bool? ?? false,
    );
  }
}
