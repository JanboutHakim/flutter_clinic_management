import 'dart:developer';

import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
// import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  late AuthRequest authRequest;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authRequest = AuthRequest.nullvalues();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          DropdownButton<GenderEnum>(
            value: authRequest.gender,
            hint: Text('اختر الجنس'),
            onChanged: (value) => (authRequest.gender = value),
            items:
                GenderEnum.values.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender.name),
                  );
                }).toList(),
          ),
          TextField(
            cursorRadius: Radius.circular(2.0),
            decoration: InputDecoration(
              label: Text("firstname"),
              constraints: BoxConstraints(maxWidth: 90.0),
            ),
            onChanged: (value) {
              authRequest.firstName = value;
            },
          ),
          TextField(
            cursorRadius: Radius.circular(2.0),
            decoration: InputDecoration(
              label: Text("lastname"),
              constraints: BoxConstraints(maxWidth: 90.0),
            ),
            onChanged: (value) {
              authRequest.lastName = value;
            },
          ),
          TextField(
            onChanged: (value) {
              authRequest.phoneNumbre = value;
            },

            cursorRadius: Radius.circular(2.0),
            decoration: InputDecoration(
              label: Text("phone"),
              constraints: BoxConstraints(maxWidth: 90.0),
            ),
          ),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date of Birth*',
              suffixIcon: const Icon(Icons.calendar_today),
              hintText:
                  authRequest.date == null
                      ? "make it easy"
                      : authRequest.date!.toIso8601String(),

              errorStyle: const TextStyle(color: Colors.red),
            ),
            validator: (value) {
              if (authRequest.date == null) {
                return 'Date of birth is required';
              }
              return null;
            },
            onTap: () async {
              final DateTime? date = await showDatePicker(
                initialDate: DateTime.now(),
                context: context,
                firstDate: DateTime(1940),
                lastDate: DateTime.now(),
              );
              date != null
                  ? setState(() {
                    authRequest.date = date;
                  })
                  : () {
                    authRequest.date = null;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select your date of birth'),
                      ),
                    );
                  };
            },
          ),

          TextField(
            cursorRadius: Radius.circular(2.0),
            decoration: InputDecoration(
              label: Text("username"),
              constraints: BoxConstraints(maxWidth: 90.0),
            ),
            onChanged: (value) {
              authRequest.username = value;
            },
          ),
          TextField(
            cursorRadius: Radius.circular(2.0),
            decoration: InputDecoration(
              label: Text("password"),
              constraints: BoxConstraints(maxWidth: 90.0),
            ),
            onChanged: (value) {
              authRequest.password = value;
            },
          ),
          TextField(
            cursorRadius: Radius.circular(2.0),
            decoration: InputDecoration(
              label: Text("addres"),
              constraints: BoxConstraints(maxWidth: 90.0),
            ),
            onChanged: (value) {
              authRequest.address = value;
            },
          ),
          TextField(
            cursorRadius: Radius.circular(2.0),
            decoration: InputDecoration(
              label: Text("email"),
              constraints: BoxConstraints(maxWidth: 90.0),
            ),
            onChanged: (value) {
              authRequest.email = value;
            },
          ),
          IconButton(
            onPressed: () {
              if (authRequest.date != null) {
                log(authRequest.date.toString());
              } else {
                log("shit");
              }
              final AuthRequest a = AuthRequest.signupAsPatient(
                username: "@ahmed",
                password: "password",
                firstName: "firstName",
                gender: GenderEnum.male,
                lastName: "lastName",
                phoneNumber: "phoneNumber",
                date: DateTime.now(),
                role: UserRoleEnum.patient,
                email: "email",
                address: "halab wlak",
              );
              context.read<AuthBlocBloc>().add(AuthSignUpAsPatietn(a));
              log(a.toJson().toString(), level: 10);
            },
            icon: Icon(Icons.check_circle),
          ),
        ],
      ),
    );
  }
}
