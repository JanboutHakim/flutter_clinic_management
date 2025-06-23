// ignore: constant_identifier_names
enum DrugStatusEnum { IN_USE, FINISHED, STOOPED, CHRONIC }

extension DrugStatus on DrugStatusEnum {
  String get displayName {
    switch (this) {
      case DrugStatusEnum.IN_USE:
        return "IN_USE";
      case DrugStatusEnum.CHRONIC:
        return "CHRONIC";
      case DrugStatusEnum.FINISHED:
        return "FINISHED";

      case DrugStatusEnum.STOOPED:
        return "STOOPED";
    }
  }

  static DrugStatusEnum? fromString(String value) {
    switch (value.toUpperCase()) {
      case 'IN_USE':
        return DrugStatusEnum.IN_USE;
      case 'STOOPED':
        return DrugStatusEnum.STOOPED;
      case 'FINISHED':
        return DrugStatusEnum.FINISHED;
      case 'CHRONIC':
        return DrugStatusEnum.CHRONIC;
      default:
        return null;
    }
  }
}
