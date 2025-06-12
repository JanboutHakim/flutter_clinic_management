enum UserRoleEnum { admin, patient, doctor, employee }

extension UserRoleExtention on UserRoleEnum {
  String get displayName {
    switch (this) {
      case UserRoleEnum.admin:
        return "ADMIN";
      case UserRoleEnum.patient:
        return "PATIENT";
      case UserRoleEnum.doctor:
        return "DOCTOR";
      case UserRoleEnum.employee:
        return "EMPLOYEE";
    }
  }

  static UserRoleEnum? fromString(String value) {
    switch (value) {
      case 'DOCTOR':
        return UserRoleEnum.doctor;
      case 'EMPLOYEE':
        return UserRoleEnum.employee;
      case 'PATIENT':
        return UserRoleEnum.patient;
      case 'ADMIN':
        return UserRoleEnum.admin;
    }
    return null;
  }
}
