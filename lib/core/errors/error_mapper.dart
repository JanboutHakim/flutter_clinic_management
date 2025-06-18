import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/core/errors/failure.dart';

/// Maps [AppException]s coming from data sources into their corresponding
/// [Failure] representation used in the domain layer.
class ErrorMapper {
  static Failure map(AppException exception) {
    switch (exception.runtimeType) {
      case ServerException _:
        return ServerFailure(exception.message, exception.details);
      case NetworkException _:
        return NetworkFailure(exception.message, exception.details);
      case UnauthorizedException _:
        return AuthFailure(exception.message, exception.details);
      case CacheException _:
        return CachFailure(exception.message);
      case NotFoundException _:
        return ServerFailure(exception.message, exception.details);
      case ValidationException _:
        return ServerFailure(exception.message, exception.details);
      default:
        return ServerFailure(exception.toString());
    }
  }
}
