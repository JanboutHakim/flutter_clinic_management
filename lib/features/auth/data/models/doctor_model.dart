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
    super.id,
    required this.yearsOfExperience,
    required this.spec,
    required this.address,
    required this.appointments,
    required this.patients,
    super.token,
    required super.birthDate,
    required super.fullName,
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
    fullName: json['Name'],
    phonNumber: json['phonNumber'],
    userGender: GenderEnum.values.firstWhere(
      (e) => e.name == json['userGender'],
    ),
    userRoleEnum: UserRoleEnum.values.firstWhere(
      (e) => e.name == json['userRoleEnum'],
    ),
    token: json['token'],
    id: json["id"],
  );

  @override
  Map<String, dynamic> toJson() => {
    'birthDate': birthDate.toIso8601String(),

    'Name': fullName,
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
      fullName: fullName,
      phonNumber: phonNumber,
      userRoleEnum: userRoleEnum,
      userGender: userGender,
    );
  }
}
