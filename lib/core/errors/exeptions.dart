abstract class AppException implements Exception {
  final String message;
  final String? details;

  AppException(this.message, [this.details = "dfsgdsfgdsf"]);

  @override
  String toString() =>
      '$runtimeType: $message${details != null ? ' ($details)' : ''}';
}

class ServerException extends AppException {
  ServerException([super.message = "Server error"]);
}

class CacheException extends AppException {
  CacheException([super.message = "Cache error", super.details = null]);
}

class NetworkException extends AppException {
  NetworkException([super.message = "Network error", super.details = null]);
}

class NotFoundException extends AppException {
  NotFoundException([
    super.message = "Resource not found",
    super.details = null,
  ]);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([super.message = "Unauthorized", super.details = null]);
}

class ValidationException extends AppException {
  ValidationException([
    super.message = "Validation failed",
    super.details = null,
  ]);
}
