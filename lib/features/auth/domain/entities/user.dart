import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';

class User {
  final String? id;
  final String? accessToken;
  final String? refreshToken;
  final String userName;
  final String fullName;
  final String phonNumber;
  final GenderEnum userGender;
  final DateTime dob;
  final UserRoleEnum userRoleEnum;
  User({
    this.id,
    this.accessToken,
    this.refreshToken,
    required this.userName,
    required this.fullName,
    required this.dob,
    required this.phonNumber,
    required this.userRoleEnum,
    required this.userGender,
  });
}
