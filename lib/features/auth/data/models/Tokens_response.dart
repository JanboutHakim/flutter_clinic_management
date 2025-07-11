class TokensResponse {
  final String accessToken;
  final String refreshToken;
  final String message;
  final bool success;

  const TokensResponse({
    required this.accessToken,
    required this.message,
    required this.refreshToken,
    required this.success,
  });

  factory TokensResponse.fromJson(Map<String, dynamic> json) {
    return TokensResponse(
      accessToken: json['accessToken'].toString(),
      refreshToken: json['refreshToken'].toString(),
      message: json['message'].toString(),
      success: json['success'].toString() == "true" ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'message': message,
      'success': success.toString(),
    };
  }
}
