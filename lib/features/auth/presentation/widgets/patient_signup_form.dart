import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientSignupForm extends StatefulWidget {
  const PatientSignupForm({super.key});

  @override
  State<PatientSignupForm> createState() => _PatientSignupFormState();
}

class _PatientSignupFormState extends State<PatientSignupForm> {
  final _formKey = GlobalKey<FormState>();
  late AuthRequest authRequest;

  @override
  void initState() {
    super.initState();
    authRequest = AuthRequest.nullvalues();
  }

  InputDecoration _decoration(BuildContext context, String label,
      {Widget? suffixIcon, String? hintText}) {
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.primary),
    );
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      suffixIcon: suffixIcon,
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<GenderEnum>(
              value: authRequest.gender,
              decoration: _decoration(context, 'Gender'),
              items: GenderEnum.values
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender.displayName),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => authRequest.gender = value),
              validator: (value) => value == null ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: _decoration(context, 'First name'),
              onChanged: (value) => authRequest.firstName = value,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: _decoration(context, 'Last name'),
              onChanged: (value) => authRequest.lastName = value,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: _decoration(context, 'Phone'),
              keyboardType: TextInputType.phone,
              onChanged: (value) => authRequest.phoneNumbre = value,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              readOnly: true,
              decoration: _decoration(
                context,
                'Date of Birth*',
                suffixIcon: const Icon(Icons.calendar_today),
                hintText: authRequest.date == null
                    ? 'Pick a date'
                    : authRequest.date!.toIso8601String(),
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
                if (date != null) {
                  setState(() {
                    authRequest.date = date;
                  });
                } else {
                  authRequest.date = null;
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select your date of birth'),
                      ),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: _decoration(context, 'Username'),
              onChanged: (value) => authRequest.username = value,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: _decoration(context, 'Password'),
              obscureText: true,
              onChanged: (value) => authRequest.password = value,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: _decoration(context, 'Address'),
              onChanged: (value) => authRequest.address = value,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: _decoration(context, 'Email'),
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
                  context.read<AuthBlocBloc>().add(AuthSignUpAsPatietn(patient));
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
