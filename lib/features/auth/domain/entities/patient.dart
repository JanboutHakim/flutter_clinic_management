import 'package:doclib/features/auth/domain/entities/user.dart';

class Patient extends User {
  final List<Object> appointments;
  final List<Object> drugs;
  final List<Object> documents;
  Patient({
    super.id,
    this.appointments = const [],
    this.documents = const [],
    this.drugs = const [],
    required super.firstName,
    required super.birthDate,
    required super.lastName,
    required super.phonNumber,
    required super.userRoleEnum,
    required super.userGender,
    super.token,
  });
}
