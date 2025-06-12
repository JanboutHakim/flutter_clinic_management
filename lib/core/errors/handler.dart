import 'dart:convert';
import 'package:doclib/core/errors/exeptions.dart';
import 'package:http/http.dart' as http;

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

T handleResponse<T>(http.Response response, JsonFactory<T> fromJson) {
  final decoded = jsonDecode(response.body);

  switch (response.statusCode) {
    case 200:
    case 201:
      return fromJson(decoded);

    case 400:
      throw ValidationException(
        decoded['message'] ?? 'Validation failed',
        decoded['details']?.toString(),
      );

    case 401:
    case 403:
      throw UnauthorizedException(
        decoded['message'] ?? 'Unauthorized',
        decoded['details']?.toString(),
      );

    case 404:
      throw NotFoundException(
        decoded['message'] ?? 'Resource not found',
        decoded['details']?.toString(),
      );

    case 500:
    case 502:
    case 503:
    case 504:
      throw ServerException(decoded['message'] ?? 'Server error');

    default:
      throw Exception(decoded['message'] ?? 'Unknown error');
  }
}
