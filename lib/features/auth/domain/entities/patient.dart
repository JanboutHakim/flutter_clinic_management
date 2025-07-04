import 'package:doclib/features/appointments/domain/appointments.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';

class Patient extends User {
  final String? address;
  final List<String>? drugs;
  final List<String>? measurements;
  final List<Appointment>? appointments;
  final List<String>? analyses;
  final List<String>? insuranceCompanies;
  final String? bloodType;
  final String? imageUrl;
  final List<String>? patientHistoryRecords;
  final double? weight;
  final String? phoneNumber;
  final String? patientId;

  Patient({
    this.address,
    this.drugs = const [],
    this.measurements = const [],
    this.appointments = const [],
    this.analyses = const [],
    this.insuranceCompanies = const [],
    this.bloodType,
    this.imageUrl,
    this.patientHistoryRecords = const [],
    this.weight,
    this.phoneNumber,
    this.patientId,
    required super.userName,
    required super.fullName,
    required super.dob,
    required super.phonNumber,
    required super.userRoleEnum,
    required super.userGender,
    super.accessToken,
    super.refreshToken,
  });
}
