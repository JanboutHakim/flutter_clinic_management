// ignore: file_names
// ignore: file_names
import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';

final AuthRequest ta = AuthRequest.nullvalues();

/// The [child] argument is required.
/// this is auth class that hold credentionals to to server
class AuthRequest {
  String? username;
  String? password;
  String? fullName;
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
    this.fullName,
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
    required String fullName,
    required GenderEnum gender,
    required String phoneNumber,
    required DateTime date,
    required String address,
    required UserRoleEnum role,
    required String spec,
  }) {
    return AuthRequest._(
      username: username,
      password: password,
      fullName: fullName,
      address: address,
      date: date,
      gender: gender,
      phoneNumbre: phoneNumber,
      role: role,
      spec: spec,
    );
  }

  factory AuthRequest.signupAsPatient({
    required String username,
    required String password,
    required String fullName,
    required GenderEnum gender,
    required String phoneNumber,
    required DateTime date,
    required UserRoleEnum role,
    required String email,
    required String address,
  }) {
    return AuthRequest._(
      username: username,
      password: password,
      fullName: fullName,
      date: date,
      gender: gender,
      phoneNumbre: phoneNumber,
      role: role,
      email: email,
      address: address,
    );
  }
  AuthRequest copyWith({
    String? username,
    String? password,
    GenderEnum? gender,
    String? fullName,
    String? phoneNumbre,
    DateTime? date,
    UserRoleEnum? role,
  }) {
    return AuthRequest._(
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      phoneNumbre: phoneNumbre ?? this.phoneNumbre,
      date: date ?? this.date,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'username': username,
      'password': password,
      if (fullName != null) 'name': fullName,
      if (role != null) 'role': role?.displayName,
      if (date != null) 'DOB': date?.toIso8601String().split('T')[0],
      if (gender != null) 'gender': gender?.displayName,
      if (phoneNumbre != null) 'phoneNumber': phoneNumbre,
      if (email != null) 'email': email,
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
