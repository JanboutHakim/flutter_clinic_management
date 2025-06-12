enum GenderEnum { male, female }

extension GenderExtension on GenderEnum {
  String get displayName {
    switch (this) {
      case GenderEnum.male:
        return 'Male';
      case GenderEnum.female:
        return 'Female';
    }
  }

  // Get from string
  static GenderEnum? fromString(String value) {
    switch (value.toLowerCase()) {
      case 'male':
        return GenderEnum.male;
      case 'female':
        return GenderEnum.female;
      default:
        return null;
    }
  }

  // Get abbreviated form
  String get abbreviation {
    switch (this) {
      case GenderEnum.male:
        return 'M';
      case GenderEnum.female:
        return 'F';
    }
  }
}
