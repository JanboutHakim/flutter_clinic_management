// import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';

class Doctor extends User {
  final String spec;
  final String address;
  final List<Object> appointments;
  final List<Object> patients;
  final int yearsOfExperience;
  Doctor({
    required super.userName,
    required super.id,
    required this.yearsOfExperience,
    required super.token,
    required this.spec,
    required this.address,
    this.appointments = const [],
    this.patients = const [],
    required super.fullName,
    required super.birthDate,
    required super.phonNumber,
    required super.userRoleEnum,
    required super.userGender,
  });
}

// Doctor dou = Doctor(
//   spec: 'spec',
//   address: 'address',
//   appointments: [],
//   patients: [],
//   firstName: 'name',
//   birthDate: DateTime.now(),
//   lastName: 'nName',
//   phonNumber: 'phonNumber',
//   userRoleEnum: UserRoleEnum.doctor,
//   userGender: GenderEnum.male,
// );
