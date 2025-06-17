import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/domain/entities/patient.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({required this.user, super.key});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          user is Patient ? Text(user.userRoleEnum.displayName) : Text(""),
          // user is Patient
          const SizedBox(height: 20),
          Text(user.fullName),
          const SizedBox(height: 20),
          Text(user.userName),
        ],
      ),
    );
  }
}
