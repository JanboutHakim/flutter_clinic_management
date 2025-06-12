// ignore: file_names
// ignore: file_names
import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';

final AuthRequest ta = AuthRequest.nullvalues();

class AuthRequest {
  /// The [child] argument is required.
  String? username;
  String? password;
  String? lastName;
  String? firstName;
  UserRoleEnum? role;
  DateTime? date;
  String? spec;
  String? phoneNumbre;
  String? address;
  GenderEnum? gender;
  String? email;

  AuthRequest.nullvalues();

  AuthRequest._({
    this.gender,
    this.address,
    this.date,
    this.lastName,
    this.firstName,
    this.phoneNumbre,
    this.role,
    this.spec,
    required this.username,
    required this.password,
    this.email,
  });
  factory AuthRequest.login({
    required String username,
    required String password,
  }) {
    return AuthRequest._(password: password, username: username);
  }
  factory AuthRequest.signupAsDoctor({
    required String username,
    required String password,
    required String firstName,
    required GenderEnum gender,
    required String lastName,
    required String phoneNumber,
    required DateTime date,
    required String address,
    required UserRoleEnum role,
    required String spec,
  }) {
    return AuthRequest._(
      username: username,
      password: password,
      firstName: firstName,
      address: address,
      date: date,
      gender: gender,
      lastName: lastName,
      phoneNumbre: phoneNumber,
      role: role,
      spec: spec,
    );
  }

  factory AuthRequest.signupAsPatient({
    required String username,
    required String password,
    required String firstName,
    required GenderEnum gender,
    required String lastName,
    required String phoneNumber,
    required DateTime date,
    required UserRoleEnum role,
    required String email,
    required String address,
  }) {
    return AuthRequest._(
      username: username,
      password: password,
      firstName: firstName,
      date: date,
      gender: gender,
      lastName: lastName,
      phoneNumbre: phoneNumber,
      role: role,
      email: email,
      address: address,
    );
  }
  AuthRequest copyWith({
    String? username,
    String? password,
    String? firstName,
    GenderEnum? gender,
    String? lastName,
    String? phoneNumbre,
    DateTime? date,
    UserRoleEnum? role,
  }) {
    return AuthRequest._(
      username: username ?? this.username,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      gender: gender ?? this.gender,
      lastName: lastName ?? this.lastName,
      phoneNumbre: phoneNumbre ?? this.phoneNumbre,
      date: date ?? this.date,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'username': username,
      'password': password,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (role != null) 'role': role?.name,
      if (date != null) 'DOB': date?.toIso8601String().split('T')[0],
      if (gender != null) 'gender': gender?.name,
      if (phoneNumbre != null) 'phoneNumber': phoneNumbre,
    };

    if (role == UserRoleEnum.doctor) {
      data['doctor'] = {
        if (address != null) 'address': address,
        if (spec != null) 'yearsOfExperience': int.tryParse(spec ?? '0'),
        'unionMembershipNumber': 'MED-${DateTime.now().millisecondsSinceEpoch}',
        'checkupDuration': 20,
      };
    } else if (role == UserRoleEnum.patient) {
      data['patient'] = {
        if (address != null) 'address': address,
        // Add other patient-specific fields here
        // Example: 'insuranceProvider': 'XYZ Insurance',
      };
    }

    return data;
  }
}
