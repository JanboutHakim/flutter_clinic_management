import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/data/models/otp_request_model.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:doclib/features/auth/domain/usecases/cach_token_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/get_cached_token_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/get_cached_user.dart';
import 'package:doclib/features/auth/domain/usecases/login_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/signup_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignUpUseCase signUpUseCase;
  final LoginUsecase loginUseCase;
  final GetCachedTokenUsecase getCachedTokenUseCase;
  final CachTokenUsecase cachTokenUseCase;
  final GetCachedUserUseCase getCachedUserUseCase;
  final VerifyOtpUsecase verifyOtpUseCase;
  AuthBlocBloc({
    required this.verifyOtpUseCase,
    required this.getCachedUserUseCase,
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.cachTokenUseCase,
    required this.getCachedTokenUseCase,
  }) : super(AuthBlocInitial()) {
    on<AuthSignUpAsPatietn>(_authsignup);
    on<AuthSignIn>(_authsigin);
    on<AuthCheckUserSession>(_authCheckSesssion);
    on<AuthOtpVerify>(_authOtpVerify);
  }

  Future<void> _authOtpVerify(
    AuthOtpVerify event,
    Emitter<AuthBlocState> emit,
  ) async {
    final result = await verifyOtpUseCase(request: event.requestModel);
    result.fold((f) => emit(AuthFailed(f.message)), (r) async {
      log("start save user token ");
      final issaved = await cachTokenUseCase(
        aToken: r.accessToken,
        rToken: r.refreshToken,
      );
      if (issaved.isRight() && issaved == true) {
        log("saved successfully");
      }
      emit(AuthAuthenticated(event.user));
    });
  }

  Future<void> _authCheckSesssion(
    AuthCheckUserSession event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthLoading());
    final result = await getCachedTokenUseCase();

    result.fold(
      (e) {
        emit(AuthUnAuthenticated());
      },
      (token) async {
        final user = await getCachedUserUseCase();
        user.fold((f) {
          emit(AuthUnAuthenticated());
        }, (r) => emit(AuthAuthenticated(r)));
      },
    );
  }

  Future<void> _authsignup(
    AuthSignUpAsPatietn event,
    Emitter<AuthBlocState> emit,
  ) async {
    // emit(AuthLoading());09
    final res = await signUpUseCase(authRequest: event.patient);
    res.fold((f) => emit(AuthFailed(f.message)), (user) async {
      // final usersave= await cachuser
      emit(AuthWaitingOtpVerify(user: user));
    });
  }

  Future<void> _authsigin(AuthSignIn event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());
    final res = await loginUseCase(authRequest: event.authRequest);
    res.fold((f) => emit(AuthFailed(f.message)), (user) {
      emit(AuthAuthenticated(user));
    });
  }
}
