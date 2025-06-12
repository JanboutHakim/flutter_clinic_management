part of 'user_role_cubit_cubit.dart';

class UserState extends Equatable {
  final UserRoleEnum? role;

  const UserState({this.role});

  UserState copyWith({UserRoleEnum? role, bool? isLoading}) {
    return UserState(role: role ?? this.role);
  }

  @override
  List<Object?> get props => [role];
}
