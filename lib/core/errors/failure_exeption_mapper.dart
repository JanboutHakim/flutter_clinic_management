import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/core/errors/failure.dart';

class ExceptionFailureMapper {
  static Failure mapExceptionToFailure(AppException exception) {
    return switch (exception) {
      ServerException _ => ServerFailure(exception.message, exception.details),
      NetworkException _ => NetworkFailure(
        exception.message,
        exception.details,
      ),
      UnauthorizedException _ => AuthFailure(exception.message),
      // CacheException _ => const CacheFailure(),
      // NotFoundException _ => const NotFoundFailure(),
      // ValidationException _ => ValidationFailure(exception.message),
      _ => ServerFailure(exception.toString()),
    };
  }
}
