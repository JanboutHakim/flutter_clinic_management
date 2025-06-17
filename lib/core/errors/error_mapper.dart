import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/core/errors/failure.dart';

/// Maps [AppException]s coming from data sources into their corresponding
/// [Failure] representation used in the domain layer.
class ErrorMapper {
  static Failure map(AppException exception) {
    switch (exception.runtimeType) {
      case ServerException:
        return ServerFailure(exception.message, exception.details);
      case NetworkException:
        return NetworkFailure(exception.message, exception.details);
      case UnauthorizedException:
        return AuthFailure(exception.message, exception.details);
      case CacheException:
        return ServerFailure(exception.message, exception.details);
      case NotFoundException:
        return ServerFailure(exception.message, exception.details);
      case ValidationException:
        return ServerFailure(exception.message, exception.details);
      default:
        return ServerFailure(exception.toString());
    }
  }
}
