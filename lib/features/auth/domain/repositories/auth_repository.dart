import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/data/models/Tokens_response.dart';
import 'package:doclib/features/auth/data/models/otp_request_model.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> cachToken({required String token});
  Future<Either<Failure, String?>> getCahedToken();
  Future<Either<Failure, User>> logIn({required AuthRequest authRequest});
  Future<Either<Failure, User>> signUp({required AuthRequest authRequest});
  Future<Either<Failure, User>> getCacheduser();
  Future<Either<Failure, bool>> cachUser(UserModel model);
  Future<Either<Failure, TokensResponse>> verfiyOtp({
    required OtpRequestModel request,
  });
}
