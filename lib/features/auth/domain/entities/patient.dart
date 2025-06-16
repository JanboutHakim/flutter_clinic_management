import 'package:doclib/features/auth/domain/entities/user.dart';

class Patient extends User {
  final List<String?>? appointments;
  final List<String?>? drugs;
  final List<String?>? documents;
  Patient({
    required super.userName,
    super.id,
    this.appointments = const [],
    this.documents = const [],
    this.drugs = const [],
    required super.fullName,
    required super.birthDate,
    required super.phonNumber,
    required super.userRoleEnum,
    required super.userGender,
    super.token,
  });
}
