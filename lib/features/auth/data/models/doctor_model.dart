import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:doclib/features/auth/domain/entities/doctor.dart';

class DoctorModel extends UserModel {
  final String spec;
  final String address;
  final List<Object> appointments;
  final List<Object> patients;
  final int yearsOfExperience;
  DoctorModel({
    required this.yearsOfExperience,
    required this.spec,
    required this.address,
    required this.appointments,
    required this.patients,
    super.token,
    required super.birthDate,
    required super.lastName,
    required super.firstName,
    required super.phonNumber,
    required super.userGender,
    required super.userRoleEnum,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    yearsOfExperience: json["yearsOfExperience"],
    spec: json['spec'],
    address: json['address'],
    appointments: (json['appointments'] as List<Object>? ?? []).toList(),
    patients: (json['patients'] as List<Object>? ?? []).toList(),
    birthDate: DateTime.parse(json['birthDate']),
    lastName: json['lastName'],
    firstName: json['firstName'],
    phonNumber: json['phonNumber'],
    userGender: GenderEnum.values.firstWhere(
      (e) => e.name == json['userGender'],
    ),
    userRoleEnum: UserRoleEnum.values.firstWhere(
      (e) => e.name == json['userRoleEnum'],
    ),
    token: json['token'],
  );

  @override
  Map<String, dynamic> toJson() => {
    'birthDate': birthDate.toIso8601String(),
    'lastName': lastName,
    'firstName': firstName,
    'phonNumber': phonNumber,
    'userGender': userGender.displayName,
    'userRoleEnum': userRoleEnum.displayName,
    'token': token,
    'spec': spec,
    'address': address,
    'appointments': appointments,
    'patients': patients,
  };

  @override
  Doctor toEntity() {
    return Doctor(
      yearsOfExperience: yearsOfExperience,
      spec: spec,
      address: address,
      appointments: List<Object>.from(appointments),
      patients: List<Object>.from(patients),
      token: token,
      birthDate: birthDate,
      lastName: lastName,
      firstName: firstName,
      phonNumber: phonNumber,
      userRoleEnum: userRoleEnum,
      userGender: userGender,
    );
  }
}
