import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/domain/entities/patient.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:doclib/features/auth/presentation/pages/login_page.dart';
import 'package:doclib/features/auth/presentation/pages/otp_page.dart';
import 'package:doclib/features/auth/presentation/pages/patient_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountRootPage extends StatelessWidget {
  const AccountRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        debugPrint(state.runtimeType.toString());
        if (state is AuthUnAuthenticated) {
          return PatientSignupPage();
        } else if (state is AuthLoading) {
          return CircularProgressIndicator();
        } else if (state is AuthWaitingOtpVerify) {
          return OtpPage();
        } else if (state is AuthAuthenticated) {
          return LoginPage();
        } else {
          return const PatientSignupPage();
        }
      },
    );
  }
}
