import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';

class User {
  String? id;
  String? token;
  final String firstName;
  final String lastName;
  final String phonNumber;
  final GenderEnum userGender;
  final DateTime birthDate;
  final UserRoleEnum userRoleEnum;
  User({
    this.id,
    this.token,
    required this.firstName,
    required this.birthDate,
    required this.lastName,
    required this.phonNumber,
    required this.userRoleEnum,
    required this.userGender,
  });
}
