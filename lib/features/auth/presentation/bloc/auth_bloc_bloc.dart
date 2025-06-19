import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:doclib/features/auth/domain/usecases/cach_token_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/get_cached_token_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/login_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignUpUseCase signUpUseCase;
  final LoginUsecase loginUsecase;
  final GetCachedTokenUsecase getCachedTokenUsecase;
  final CachTokenUsecase cachTokenUsecase;
  AuthBlocBloc({
    required this.loginUsecase,
    required this.signUpUseCase,
    required this.cachTokenUsecase,
    required this.getCachedTokenUsecase,
  }) : super(AuthBlocInitial()) {
    on<AuthSignUpAsPatietn>(_authsignup);
    on<AuthSignIn>(_authsigin);
    on<AuthCheckUserSession>(_authCheckSesssion);
  }
  Future<void> _authCheckSesssion(
    AuthCheckUserSession event,
    Emitter<AuthBlocState> emit,
  ) async {
    final result = await getCachedTokenUsecase();

    result.fold(
      (e) {
        emit(AuthFailed(e.message));
      },
      (token) {
        if (token == null) {
          emit(AuthUnAuthenticated());
        } else {
          // emit(AuthAuthenticated());
        }
      },
    );
  }

  Future<void> _authsignup(
    AuthSignUpAsPatietn event,
    Emitter<AuthBlocState> emit,
  ) async {
    final res = await signUpUseCase(authRequest: event.patient);
    res.fold((f) => emit(AuthFailed(f.message)), (user) async {
      emit(AuthAuthenticated(user));
      final saved = await cachTokenUsecase(token: user.token);
    });
  }

  Future<void> _authsigin(AuthSignIn event, Emitter<AuthBlocState> emit) async {
    final res = await loginUsecase(authRequest: event.authRequest);
    res.fold((f) => emit(AuthFailed(f.message)), (user) {
      emit(AuthAuthenticated(user));
    });
  }
}
