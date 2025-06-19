import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/core/errors/error_mapper.dart';
import 'package:doclib/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:doclib/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSourece;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl({
    required this.authRemoteDataSourece,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, User>> logIn({
    required AuthRequest authRequest,
  }) async {
    try {
      final entity = await authRemoteDataSourece.login(
        authreRuest: authRequest,
      );
      return right(entity.toEntity());
    } on AppException catch (e) {
      return left(ErrorMapper.map(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
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
      // } on AppException catch (e) {
      //   return left(ErrorMapper.map(e));
      // }
    } catch (e, stack) {
      log(stack.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> cachToken({required String token}) async {
    try {
      final succes = await authLocalDataSource.cacheToken(token);
      return right(succes);
    } catch (e) {
      return left(CachFailure("error when cash token"));
    }
  }

  @override
  Future<Either<Failure, String?>> getCahedToken() async {
    try {
      final token = await authLocalDataSource.getCachedToken();
      return right(token);
    } catch (e) {
      return left(
        CachFailure(
          "error when get the local token / the exeption is  ${e.runtimeType}",
        ),
      );
    }
  }
}
