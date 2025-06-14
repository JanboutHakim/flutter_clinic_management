import 'dart:developer';
import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:doclib/features/auth/presentation/widgets/custom_text_form_field.dart';
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
  bool _genderValid = true;
  bool _dateValid = true;

  @override
  void initState() {
    super.initState();
    authRequest = AuthRequest.nullvalues();
    authRequest.gender = GenderEnum.male;
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
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/new.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            autovalidateMode: AutovalidateMode.onUnfocus,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              DropdownButtonFormField<GenderEnum>(
                autovalidateMode: AutovalidateMode.always,
                value: authRequest.gender ?? GenderEnum.male,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _genderValid ? Colors.green : Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _genderValid ? Colors.green : Colors.blue,
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                items: GenderEnum.values
                    .map(
                      (gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() {
                  authRequest.gender = value;
                  _genderValid = value != null;
                }),
                validator: (value) {
                  _genderValid = value != null;
                  return value == null ? 'Required' : null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: authRequest.date == null
                      ? 'Date of Birth*'
                      : authRequest.date.toString(),
                  suffixIcon: const Icon(Icons.calendar_today),
                  hintText: authRequest.date == null
                      ? 'Pick a date'
                      : authRequest.date!.toIso8601String(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _dateValid ? Colors.green : Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _dateValid ? Colors.green : Colors.blue,
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                validator: (value) {
                  _dateValid = authRequest.date != null;
                  if (!_dateValid) {
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
                  if (date != null) {
                    setState(() {
                      authRequest.date = date;
                      _dateValid = true;
                    });
                  } else {
                    setState(() {
                      _dateValid = false;
                      authRequest.date = null;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select your date of birth'),
                      ),
                    );
                  }
                },
              ),
              CustomTextFormField(
                label: 'First name',
                onChanged: (value) => authRequest.firstName = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: 'Last name',
                onChanged: (value) => authRequest.lastName = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: 'Phone',
                keyboardType: TextInputType.phone,
                onChanged: (value) => authRequest.phoneNumbre = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),

              CustomTextFormField(
                label: 'Username',
                onChanged: (value) => authRequest.username = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: 'Password',
                obscureText: true,
                onChanged: (value) => authRequest.password = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: 'Address',
                onChanged: (value) => authRequest.address = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => authRequest.email = value,
                validator: (value) =>
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
                    context.read<AuthBlocBloc>().add(
                      AuthSignUpAsPatietn(patient),
                    );
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
