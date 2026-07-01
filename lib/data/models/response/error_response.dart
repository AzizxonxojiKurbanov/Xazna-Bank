class ErrorResponse {
  final bool success;
  final ApiError error;

  ErrorResponse({required this.success, required this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      success: json["success"] == true,
      error: ApiError.fromJson(json["error"] as Map<String, dynamic>? ?? {}),
    );
  }
}

class ApiError {
  final String code;
  final String message;

  ApiError({required this.code, required this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json["code"] as String? ?? "",
      message: json["message"] as String? ?? "Noma'lum xatolik yuz berdi",
    );
  }
}
