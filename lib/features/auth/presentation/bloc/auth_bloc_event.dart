part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUpAsAdoctor extends AuthBlocEvent {
  final AuthRequest doctor;
  const AuthSignUpAsAdoctor(this.doctor);
}

class AuthSignUpAsPatietn extends AuthBlocEvent {
  final AuthRequest patient;
  const AuthSignUpAsPatietn(this.patient);
}

class AuthSignIn extends AuthBlocEvent {
  final AuthRequest authRequest;
  const AuthSignIn(this.authRequest);
}

class AuthSignOut extends AuthBlocEvent {}

class AuthCheckUserSession extends AuthBlocEvent {}

class AuthOtpVerify extends AuthBlocEvent {
  final User user;
  final OtpRequestModel requestModel;
  const AuthOtpVerify({required this.requestModel, required this.user});
}
