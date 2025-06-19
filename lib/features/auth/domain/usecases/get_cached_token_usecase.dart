import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';

class GetCachedTokenUsecase {
  final AuthRepository authRepository;
  const GetCachedTokenUsecase(this.authRepository);
  Future<Either<Failure, String?>> call() {
    return authRepository.getCahedToken();
  }
}
