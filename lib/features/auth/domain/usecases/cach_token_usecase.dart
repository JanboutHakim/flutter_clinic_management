import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';

class CachTokenUsecase {
  final AuthRepository authRepository;
  const CachTokenUsecase(this.authRepository);
  Future<Either<Failure, bool>> call({required String token}) {
    return authRepository.cachToken(token: token);
  }
}
