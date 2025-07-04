// import 'package:doclib/core/constants/gender_enum.dart';
// import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';

abstract class UserModel extends User {
  UserModel({
    required super.userName,
    super.id,
    required super.dob,
    required super.fullName,
    required super.phonNumber,
    required super.userGender,
    required super.userRoleEnum,
    super.accessToken,
    super.refreshToken,
  });
  User toEntity();
  UserModel fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
