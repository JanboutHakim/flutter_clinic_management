import 'dart:developer';

import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/features/auth/data/models/doctor_model.dart';
import 'package:doclib/features/auth/data/models/patient_model.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';

class UserMapper {
  static UserModel fromJson(Map<String, dynamic> json) {
    final role = UserRoleEnum.values.firstWhere(
      (e) => e.displayName == json['role'].toString(),
    );
    // final role=UserRoleEnum.
    log(
      "now role has recieved${role.displayName} /n and the json mapper is ${json.toString()} ",
    );
    switch (role) {
      case UserRoleEnum.doctor:
        log("doctor mapper");
        return DoctorModel.fromJson(json);
      case UserRoleEnum.patient:
        log("pateint mapper");
        return PatientModel.fromJson(json);
      default:
        log("exeption");
        throw ServerException();
    }
  }
}
