import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/appointments/data/models/appointment_model.dart';
import 'package:doclib/features/appointments/domain/appointments.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';
import 'package:doclib/features/auth/domain/entities/patient.dart';

/// Represents the data returned when a patient registers or logs in.
///
/// This model extends [UserModel] with additional patient-specific
/// details like appointments, drugs, and medical documents.
///
/// Example response JSON:
/// ```json
/// {
///   "id": 16,
///   "username": "hafizalasad",
///   "name": "jojo",
///   "email": "john.doe@example.com",
///   "phoneNumber": "1234567890",
///   "DOB": "1990-05-25",
///   "role": "PATIENT",
///   "gender": "MALE",
///   "createdAt": "2025-06-18",
///   "imageUrl": "https://example.com/images/johndoe.png",
///   "patient": {
///     "patientId": 16,
///     "address": "seif-aldoule",
///     "analyses": null,
///     "patientHistoryRecords": null,
///     "drugs": null,
///     "appointments": null,
///     "insuranceCompanies": null,
///     "measurements": null
///   },
///   "doctor": null
/// }
/// ```
class PatientModel extends UserModel {
  /// List of appointment identifiers or details related to the patient.
  final List<Appointment>? appointments;

  /// List of drug identifiers or names prescribed to the patient.
  final List<String>? drugs;

  /// List of document identifiers or URLs tied to the patient.
  final List<String>? documents;

  PatientModel({
    required super.userName,
    super.id,
    super.accessToken,
    super.refreshToken,
    required super.dob,
    required super.fullName,
    required super.phonNumber,
    required super.userGender,
    required super.userRoleEnum,
    required this.appointments,
    required this.drugs,
    required this.documents,
  });

  /// Parses a [PatientModel] from a JSON map.
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      appointments:
          json['patient']?['appointments'] != null
              ? List<Appointment>.from(
                (json['patient']['appointments'] as List).map(
                  (appointmentJson) =>
                      AppointmentModel.fromJson(appointmentJson),
                ),
              )
              : null, // Replace with JSON parsing if available
      drugs: null,
      documents: null,
      dob: DateTime.parse(json['DOB']),
      fullName: json['name'].toString(),
      phonNumber: json['phoneNumber'].toString(),
      userGender: GenderEnum.values.firstWhere(
        (e) => e.displayName == json['gender'],
      ),
      userRoleEnum: UserRoleEnum.patient,
      id: json["id"].toString(),
      userName: json['username'],
    );
  }

  /// Converts this model into the corresponding domain entity.
  @override
  Patient toEntity() {
    return Patient(
      appointments: appointments,
      drugs: drugs,
      fullName: fullName,
      dob: dob,
      phonNumber: phonNumber,
      userRoleEnum: userRoleEnum,
      userGender: userGender,
      accessToken: accessToken,
      refreshToken: refreshToken,
      userName: userName,
      patientId: id,
    );
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return PatientModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': userName,
      'name': fullName,
      'email': '', // Add if available
      'phoneNumber': phonNumber,
      'DOB': dob.toIso8601String(),
      'role': userRoleEnum.name,
      'gender': userGender.displayName,
      'token': accessToken,
      'refreshtoken': refreshToken,
      'appointments': appointments,
      'drugs': drugs,
      'documents': documents,
    };
  }
}
