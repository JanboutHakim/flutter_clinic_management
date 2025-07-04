import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/core/errors/error_mapper.dart';
import 'package:doclib/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:doclib/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/data/models/Tokens_response.dart';
import 'package:doclib/features/auth/data/models/otp_request_model.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, User>> logIn({
    required AuthRequest authRequest,
  }) async {
    try {
      final entity = await authRemoteDataSource.login(authrequest: authRequest);
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
    late User user;
    try {
      final model = await authRemoteDataSource.register(
        authRequest: authRequest,
      );
      log(model.runtimeType.toString());

      final isSaved = await cachUser(model);
      isSaved.fold((l) => left(l), (r) {
        r == true
            ? user = model.toEntity()
            : {
              log("success but not saved after sign up "),
              user = model.toEntity(),
            };
      });
      return Right(user);
    } catch (e, stack) {
      log(stack.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> cachToken({
    required String aToken,
    required String rToken,
  }) async {
    try {
      final success = await authLocalDataSource.cacheTokens(aToken, rToken);
      return right(success);
    } catch (e) {
      return left(CachFailure("error when cash token"));
    }
  }

  @override
  Future<Either<Failure, List<String?>>> getCahedToken() async {
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

  @override
  Future<Either<Failure, bool>> cachUser(UserModel model) async {
    try {
      final succ = await authLocalDataSource.cacheUserData(model);
      if (succ) {
        return right(succ);
      }
    } catch (e, s) {
      log(s.toString());
      return left(CachFailure("error "));
    }
    throw CacheException();
  }

  @override
  Future<Either<Failure, User>> getCacheduser() async {
    try {
      final user = await authLocalDataSource.getCachedUser();
      if (user == null)
        // ignore: curly_braces_in_flow_control_structures
        return left(CachFailure("there is no user data localy"));
      else
        // ignore: curly_braces_in_flow_control_structures
        return Right(user.toEntity());
    } catch (e) {
      return left(CachFailure("no data"));
    }
  }

  @override
  Future<Either<Failure, TokensResponse>> verfiyOtp({
    required OtpRequestModel request,
  }) async {
    try {
      final response = await authRemoteDataSource.otpVerify(request: request);
      return right(response);
    } on UnauthorizedException {
      return left(AuthFailure("UnAuthorized"));
    } catch (e) {
      return left(AuthFailure());
    }
  }
}
