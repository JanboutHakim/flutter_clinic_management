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
    // required super.password,
    required super.userName,
    required super.id,
    required this.yearsOfExperience,
    required this.spec,
    required this.address,
    required this.appointments,
    required this.patients,
    super.accessToken,
    super.refreshToken,
    required super.dob,
    required super.fullName,
    required super.phonNumber,
    required super.userGender,
    required super.userRoleEnum,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    userName: json['username'],
    yearsOfExperience: json["yearsOfExperience"],
    spec: json['spec'],
    address: json['address'],
    appointments: (json['appointments'] as List<Object>? ?? []).toList(),
    patients: (json['patients'] as List<Object>? ?? []).toList(),
    dob: DateTime.parse(json['birthDate']),
    fullName: json['Name'],
    phonNumber: json['phonNumber'],
    userGender: GenderEnum.values.firstWhere(
      (e) => e.name == json['userGender'],
    ),
    userRoleEnum: UserRoleEnum.values.firstWhere(
      (e) => e.name == json['userRoleEnum'],
    ),
    id: json["id"],
    // password: json["password"],
  );

  @override
  Map<String, dynamic> toJson() => {
    'birthDate': dob.toIso8601String(),
    'Name': fullName,
    'phonNumber': phonNumber,
    'userGender': userGender.displayName,
    'userRoleEnum': userRoleEnum.displayName,
    'token': refreshToken,
    'spec': spec,
    'address': address,
    'appointments': appointments,
    'patients': patients,
    'refreshtoken': refreshToken,
  };

  @override
  Doctor toEntity() {
    return Doctor(
      yearsOfExperience: yearsOfExperience,
      spec: spec,
      address: address,
      appointments: List<String>.from(appointments),
      patients: List<String>.from(patients),
      accessToken: accessToken,
      refreshToken: refreshToken,
      dob: dob,
      fullName: fullName,
      phonNumber: phonNumber,
      userRoleEnum: userRoleEnum,
      userGender: userGender,
      userName: userName,
      id: id,
    );
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return DoctorModel.fromJson(json);
  }
}
