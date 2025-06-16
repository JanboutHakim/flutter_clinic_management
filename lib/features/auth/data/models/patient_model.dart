import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:doclib/features/auth/domain/entities/patient.dart';

class PatientModel extends UserModel {
  final List<String>? appointments;
  final List<String>? drugs;
  final List<String>? documents;
  PatientModel({
    required super.password,
    required super.userName,
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
    appointments: null,
    //  (json['appointments'] as List<Object>? ?? []).toList(),
    drugs: null,
    // (json['drugs'] as List<Object>? ?? []).toList(),
    documents: null,
    //  (json['documents'] as List<Object>? ?? []).toList(),
    birthDate: DateTime.parse(json['DOB']),
    fullName: json['name'] ?? "hajradoooooooooo",
    phonNumber: json['phonNumber'],
    userGender:
        //  GenderEnum.values.firstWhere(
        //   (e) => e.displayName == json['gender'],
        // )??
        GenderEnum.female,
    userRoleEnum: UserRoleEnum.patient,
    token: json['token'],
    id: json["id"],
    userName: json['username'],
    password: json["password"],
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
      appointments: appointments,
      drugs: drugs,
      documents: documents,
      fullName: fullName,
      birthDate: birthDate,
      phonNumber: phonNumber,
      userRoleEnum: userRoleEnum,
      userGender: userGender,
      token: token,
      userName: userName,
    );
  }

  @override
  String toString() {
    return 'PatientModel(appointments: $appointments, drugs: $drugs, documents: $documents, token: $token, birthDate: $birthDate, firstName: $fullName, phonNumber: $phonNumber, userGender: $userGender, userRoleEnum: $userRoleEnum)';
  }
}
