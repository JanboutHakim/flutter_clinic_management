import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:doclib/features/auth/presentation/widgets/patient_signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientSignupPage extends StatelessWidget {
  const PatientSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registered successfully')),
          );
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.massege)),
          );
        }
      },
      child: const PatientSignupForm(),
    );
  }
}
