import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? details;

  const Failure(this.message, [this.details]);

  @override
  List<Object?> get props => [message, details];

  @override
  String toString() =>
      '$runtimeType: $message${details != null ? ' ($details)' : ''}';
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server failure", super.details]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.mesage = "No internet connection",
    super.details,
  ]);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = "Authentication failed", super.details]);
}
