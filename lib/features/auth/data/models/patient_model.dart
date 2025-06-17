import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:doclib/features/auth/domain/entities/patient.dart';

class PatientModel extends UserModel {
  final List<String>? appointments;
  final List<String>? drugs;
  final List<String>? documents;
  PatientModel({
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
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    // debugPrint(" ths json is ${json.toString()}", wrapWidth: 10);
    return PatientModel(
      appointments: null,
      //  (json['appointments'] as List<Object>? ?? []).toList(),
      drugs: null,
      // (json['drugs'] as List<Object>? ?? []).toList(),
      documents: null,
      //  (json['documents'] as List<Object>? ?? []).toList(),
      birthDate: DateTime.parse(json['DOB']),
      fullName: json['name'],
      phonNumber: json['phoneNumber'],
      userGender: GenderEnum.values.firstWhere(
        (e) => e.displayName == json['gender'],
      ),
      userRoleEnum: UserRoleEnum.patient,
      token: json['token'],
      id: json["id"].toString(),
      userName: json['username'],
      // password: json["password"].toString(),
    );
  }
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
