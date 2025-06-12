import 'package:doclib/core/constants/user_role_enum.dart';
import 'package:doclib/features/auth/data/models/doctor_model.dart';
import 'package:doclib/features/auth/data/models/patient_model.dart';
import 'package:doclib/features/auth/data/models/user_model.dart';

class UserMapper {
  static UserModel fromJson(Map<String, dynamic> json) {
    final role = UserRoleEnum.values.firstWhere(
      (e) => e.displayName == json['userRoleEnum'],
    );
    switch (role) {
      case UserRoleEnum.doctor:
        return DoctorModel.fromJson(json);
      case UserRoleEnum.patient:
        return PatientModel.fromJson(json);
      default:
        throw Exception();
    }
  }
}
