import 'dart:developer';

import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/core/errors/exeptions.dart';
import 'package:doclib/features/auth/data/models/doctor_model.dart';
import 'package:doclib/features/auth/data/models/patient_model.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';

class RoleExeption extends AppException {
  RoleExeption(super.message);
}

class UserMapper {
  static UserModel fromJson(Map<String, dynamic> json) {
    log("the json in model mapper is ${json.toString()}");
    final data = json['data'];
    final role = UserRoleEnum.values.firstWhere(
      (e) => e.displayName == data['role'],
    );
    // late UserRoleEnum role;
    // try {
    //   log("the json role is ${json['data'].toString()}");
    //   final newrole = UserRoleExtention.fromString(data['role'].toString());
    //   log(newrole.runtimeType.toString());
    //   if (newrole != null)
    //     role = newrole;
    //   else
    //     throw RoleExeption("role fetch ");
    //   log(
    //     "now role has recieved${role!.displayName} /n and the json mapper is ${json.toString()} ",
    //   );
    // } catch (e, s) {
    //   log(s.toString());
    // }
    switch (role) {
      case UserRoleEnum.doctor:
        log("doctor mapper");
        return DoctorModel.fromJson(data);
      case UserRoleEnum.patient:
        log("pateint mapper");
        return PatientModel.fromJson(data);
      default:
        log("exeption");
        throw ServerException();
    }
  }
}
