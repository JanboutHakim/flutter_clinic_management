import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:doclib/features/auth/domain/entities/patient.dart';

class PatientModel extends UserModel {
  final List<Object> appointments;
  final List<Object> drugs;
  final List<Object> documents;
  PatientModel({
    super.id,
    super.token,
    required super.birthDate,
    required super.fullName,
    required super.phonNumber,
    required super.userGender,
    required super.userRoleEnum,
    required this.appointments,
    required this.drugs,
    required this.documents,
  });
  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    appointments: (json['appointments'] as List<Object>? ?? []).toList(),
    drugs: (json['drugs'] as List<Object>? ?? []).toList(),
    documents: (json['documents'] as List<Object>? ?? []).toList(),
    birthDate: DateTime.parse(json['birthDate']),
    fullName: json['fullName'],
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
    'appointments': appointments,
    'drugs': drugs,
    'documents': documents,
  };
  @override
  Patient toEntity() {
    return Patient(
      appointments: List<Object>.from(appointments),
      drugs: List<Object>.from(drugs),
      documents: List<Object>.from(documents),
      fullName: fullName,
      birthDate: birthDate,
      phonNumber: phonNumber,
      userRoleEnum: userRoleEnum,
      userGender: userGender,
      token: token,
    );
  }

  @override
  String toString() {
    return 'PatientModel(appointments: $appointments, drugs: $drugs, documents: $documents, token: $token, birthDate: $birthDate, firstName: $fullName, phonNumber: $phonNumber, userGender: $userGender, userRoleEnum: $userRoleEnum)';
  }
}
