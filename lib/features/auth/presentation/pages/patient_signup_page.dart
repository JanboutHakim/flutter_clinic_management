import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:doclib/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:doclib/features/auth/presentation/widgets/dob_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  GenderEnum? _selectedGender = GenderEnum.male;
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();
  bool _genderValid = true;
  bool _dateValid = true;

  // Controllers for all text fields to enable easier management and clearing
  final TextEditingController _fullNameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();

    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Clears all controllers and resets the form
  void _clearControllers() {
    _fullNameController.clear();
    _phoneController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _addressController.clear();
    _emailController.clear();
    _formKey.currentState?.reset();
    setState(() {
      _selectedGender = GenderEnum.male;
      _selectedDate = null;
      _dateValid = true;
      _genderValid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registered successfully')),
          );
          _clearControllers();
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
            fit: BoxFit.contain,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            // autovalidateMode: AutovalidateMode.onUnfocus,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<GenderEnum>(
                  value: _selectedGender,
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
                        _selectedGender = value;
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
                    labelText:
                        _selectedDate == null
                            ? 'Date of Birth*'
                            : _selectedDate.toString(),
                    suffixIcon: const Icon(Icons.calendar_today),
                    hintText:
                        _selectedDate == null
                            ? 'Pick a date'
                            : _selectedDate!.toIso8601String(),
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
                    _dateValid = _selectedDate != null;
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
                        _selectedDate = date;
                        _dateValid = true;
                      });
                    } else {
                      setState(() {
                        _dateValid = false;
                        _selectedDate = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select your date of birth'),
                        ),
                      );
                    }
                  },
                ),
                // DatePickerField(sellectedDate: _selectedDate),
                TextFormField(
                  controller: _fullNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'fullName',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color:
                            _fullNameController.text.isEmpty
                                ? Colors.grey
                                : Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                  onChanged: (_) => setState(() {}),
                ),

                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color:
                            _phoneController.text.isEmpty
                                ? Colors.grey
                                : Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                  onChanged: (_) => setState(() {}),
                ),

                TextFormField(
                  controller: _usernameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color:
                            _usernameController.text.isEmpty
                                ? Colors.grey
                                : Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color:
                            _passwordController.text.isEmpty
                                ? Colors.grey
                                : Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _addressController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color:
                            _addressController.text.isEmpty
                                ? Colors.grey
                                : Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color:
                            _emailController.text.isEmpty
                                ? Colors.grey
                                : Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final patient = AuthRequest.signupAsPatient(
                        username: _usernameController.text,
                        password: _passwordController.text,

                        gender: _selectedGender!,
                        fullName: _fullNameController.text,
                        phoneNumber: _phoneController.text,
                        date: _selectedDate!,
                        role: UserRoleEnum.patient,
                        email: _emailController.text,
                        address: _addressController.text,
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
      ),
    );
  }
}
