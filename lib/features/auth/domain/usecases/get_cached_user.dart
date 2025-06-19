import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';

class GetCachedUserUseCase {
  final AuthRepository authRepository;
  const GetCachedUserUseCase(this.authRepository);
  Future<Either<Failure, User>> call() async {
    return await authRepository.getCacheduser();
  }
}
