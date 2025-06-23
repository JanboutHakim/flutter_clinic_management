import 'package:doclib/features/drugs/domain/entities/Drug_common_entity.dart';

class DrugCommonModel extends DrugCommonEntity {
  const DrugCommonModel({
    required super.company,
    required super.drugId,
    required super.medicationDosage,
    required super.name,
    required super.pharmaceuticalForm,
    required super.scientificName,
  });

  factory DrugCommonModel.fromJson(Map<String, dynamic> json) {
    return DrugCommonModel(
      drugId: json['drugId'].toString(),
      name: json['name'].toString(),
      scientificName: json['scientificName'].toString(),
      medicationDosage: json['medicationDosage'].toString(),
      pharmaceuticalForm: json['pharmaceuticalForm'].toString(),
      company: json['company'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drugId': drugId,
      'name': name,
      'scientificName': scientificName,
      'medicationDosage': medicationDosage,
      'pharmaceuticalForm': pharmaceuticalForm,
      'company': company,
    };
  }

  DrugCommonModel copyWith({
    String? drugId,
    String? name,
    String? scientificName,
    String? medicationDosage,
    String? pharmaceuticalForm,
    String? company,
  }) {
    return DrugCommonModel(
      drugId: drugId ?? this.drugId,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      medicationDosage: medicationDosage ?? this.medicationDosage,
      pharmaceuticalForm: pharmaceuticalForm ?? this.pharmaceuticalForm,
      company: company ?? this.company,
    );
  }
}
