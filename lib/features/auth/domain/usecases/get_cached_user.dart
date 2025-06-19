import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:doclib/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';

class GetCachedUserUserCase {
  final AuthRepository authRepository;
  const GetCachedUserUserCase(this.authRepository);
  Future<Either<Failure, User>> call() async {
    return await authRepository.getCacheduser();
  }
}
