import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doclib/features/auth/data/models/Tokens_response.dart';
import 'package:doclib/features/auth/data/models/otp_request_model.dart';
import 'package:doclib/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUsecase {
  final AuthRepository authRepository;
  const VerifyOtpUsecase(this.authRepository);
  Future<Either<Failure, TokensResponse>> call({
    required OtpRequestModel request,
  }) async {
    return await authRepository.verfiyOtp(request: request);
  }
}
