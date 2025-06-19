// import 'package:doclib/core/constants/gender_enum.dart';
// import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';

abstract class UserModel extends User {
  // final String password;
  UserModel({
    // required this.password,
    required super.userName,
    required super.id,
    required super.birthDate,
    required super.fullName,
    required super.phonNumber,
    required super.userGender,
    required super.userRoleEnum,
    required super.token,
  });
  User toEntity();
  UserModel fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
