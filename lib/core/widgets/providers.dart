import 'package:doclib/core/Di/di.dart' as di;
import 'package:doclib/core/utils/cubit/user_role_cubit_cubit.dart';
import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Providers extends StatelessWidget {
  const Providers({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserRoleCubitCubit>(create: (_) => UserRoleCubitCubit()),

        BlocProvider<AuthBlocBloc>(create: (_) => di.getIt<AuthBlocBloc>()),
      ],

      child: child,
    );
  }
}
