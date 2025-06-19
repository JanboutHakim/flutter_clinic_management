import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';

class User {
  final String id;
  final String token;
  final String userName;
  final String fullName;
  final String phonNumber;
  final GenderEnum userGender;
  final DateTime birthDate;
  final UserRoleEnum userRoleEnum;
  User({
    required this.id,
    required this.token,
    required this.userName,
    required this.fullName,
    required this.birthDate,
    required this.phonNumber,
    required this.userRoleEnum,
    required this.userGender,
  });
}
