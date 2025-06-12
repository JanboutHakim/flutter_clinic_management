import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> logIn({required AuthRequest authRequest});
  Future<Either<Failure, User>> signUp({required AuthRequest authRequest});
}
