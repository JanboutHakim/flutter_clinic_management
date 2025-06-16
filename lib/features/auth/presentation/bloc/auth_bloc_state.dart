part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class AuthUnAuthenticated extends AuthBlocState {}

final class AuthAuthenticated extends AuthBlocState {
  final User user;
  const AuthAuthenticated(this.user);
}

final class AuthFailed extends AuthBlocState {
  final String massege;
  final DateTime time = DateTime.now();
  AuthFailed(this.massege);
  @override
  // TODO: implement props
  List<Object> get props => [massege, time];
}
