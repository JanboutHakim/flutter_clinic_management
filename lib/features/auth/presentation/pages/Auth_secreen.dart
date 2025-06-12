import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/core/utils/cubit/user_role_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRoleCubitCubit, UserState>(
      builder: (context, state) {
        return state.role == UserRoleEnum.doctor
            ? Text("doctor")
            : Text("${state.role}");
      },
    );
  }
}
