class DrugCommonEntity {
  final String drugId;
  final String name;
  final String scientificName;
  final String medicationDosage;
  final String pharmaceuticalForm;
  final String company;
  const DrugCommonEntity({
    required this.company,
    required this.drugId,
    required this.medicationDosage,
    required this.name,
    required this.pharmaceuticalForm,
    required this.scientificName,
  });
}
