import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  const LoginUsecase({required this.authRepository});
  Future<Either<Failure, User>> call({required AuthRequest authRequest}) async {
    return await authRepository.logIn(authRequest: authRequest);
  }
}
