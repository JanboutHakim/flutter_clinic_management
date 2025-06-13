import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:doclib/features/auth/domain/usecases/login_usecase.dart';
import 'package:doclib/features/auth/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignUpUseCase signUpUseCase;
  final LoginUsecase loginUsecase;
  AuthBlocBloc({required this.loginUsecase, required this.signUpUseCase})
    : super(AuthBlocInitial()) {
    on<AuthBlocEvent>((event, emit) {});
    on<AuthSignUpAsPatietn>(_authsignup);
    on<AuthSignIn>(_authsigin);
  }
  Future<void> _authsignup(
    AuthSignUpAsPatietn event,
    Emitter<AuthBlocState> emit,
  ) async {
    final res = await signUpUseCase(authRequest: event.patient);
    res.fold(
      (f) => emit(AuthFailed(f.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _authsigin(AuthSignIn event, Emitter<AuthBlocState> emit) async {
    final res = await loginUsecase(authRequest: event.authRequest);
    res.fold(
      (f) => emit(AuthFailed(f.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }
}
