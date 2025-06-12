import 'package:bloc/bloc.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:equatable/equatable.dart';

part 'user_role_cubit_state.dart';

class UserRoleCubitCubit extends Cubit<UserState> {
  UserRoleEnum? role;
  UserRoleCubitCubit({this.role}) : super(UserState());

  void setUserRole(UserRoleEnum role) {
    emit(state.copyWith(role: role));
  }
}
