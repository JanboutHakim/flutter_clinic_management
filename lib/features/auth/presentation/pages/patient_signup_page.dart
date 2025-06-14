import 'dart:developer';
import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authRequest = AuthRequest.nullvalues();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registered successfully')),
          );
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.massege)));
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<GenderEnum>(
                value: authRequest.gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items:
                    GenderEnum.values
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender.name),
                          ),
                        )
                        .toList(),
                onChanged:
                    (value) => setState(() {
                      authRequest.gender = value;
                      _formKey.currentState!.validate();
                    }),
                validator: (value) => value == null ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'First name'),
                onChanged: (value) => authRequest.firstName = value,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last name'),
                onChanged: (value) => authRequest.lastName = value,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                onChanged: (value) => authRequest.phoneNumbre = value,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date of Birth*',
                  suffixIcon: const Icon(Icons.calendar_today),
                  hintText:
                      authRequest.date == null
                          ? 'Pick a date'
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
                        _formKey.currentState!.validate();
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

              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                onChanged: (value) => authRequest.username = value,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) => authRequest.password = value,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onChanged: (value) => authRequest.address = value,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => authRequest.email = value,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final patient = AuthRequest.signupAsPatient(
                      username: authRequest.username!,
                      password: authRequest.password!,
                      firstName: authRequest.firstName!,
                      gender: authRequest.gender!,
                      lastName: authRequest.lastName!,
                      phoneNumber: authRequest.phoneNumbre!,
                      date: authRequest.date!,
                      role: UserRoleEnum.patient,
                      email: authRequest.email!,
                      address: authRequest.address!,
                    );
                    // context.read<AuthBlocBloc>().add(
                    //   AuthSignUpAsPatietn(patient),
                    // );
                    setState(() {
                      authRequest = AuthRequest.nullvalues();
                    });
                    log(patient.toJson().toString());
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
