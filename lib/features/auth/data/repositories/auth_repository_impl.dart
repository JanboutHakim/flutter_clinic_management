import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/auth/data/datasources/auth_patient_remote_data_source.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSourece;
  AuthRepositoryImpl({required this.authRemoteDataSourece});

  @override
  Future<Either<Failure, User>> logIn({
    required AuthRequest authRequest,
  }) async {
    try {
      final entity = await authRemoteDataSourece.login(
        authreRuest: authRequest,
      );
      return right(entity.toEntity());
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required AuthRequest authRequest,
  }) async {
    try {
      final entity = await authRemoteDataSourece.register(
        authRequest: authRequest,
      );
      log(entity.runtimeType.toString());
      return right(entity.toEntity());
    } catch (e, stack) {
      log(stack.toString());
      // log(entity.runtimeType.toString());
      return left(ServerFailure());
    }
  }
}
