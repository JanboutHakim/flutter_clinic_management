// import 'package:doclib/core/constants/gender_enum.dart';
// import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/domain/entities/user.dart';

abstract class UserModel extends User {
  UserModel({
    required super.birthDate,
    required super.lastName,
    required super.firstName,
    required super.phonNumber,
    required super.userGender,
    required super.userRoleEnum,
    super.token,
  });
  Map<String, dynamic> toJson() {
    return {
      'birthDate': birthDate.toIso8601String(),
      'lastName': lastName,
      'firstName': firstName,
      'phonNumber': phonNumber,
      'userGender': userGender.displayName,
      'userRoleEnum': userRoleEnum.displayName,
    };
  }

  User toEntity();
}
