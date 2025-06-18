// ignore_for_file: public_member_api_docs, sort_constructors_first
class DrugEntity {
  final String name;
  final String dosage;
  final int frequency;
  final DateTime? startDate;
  final DateTime? endDate;
  final String drugStatus;
  final bool isNew;
  final String? drugId;
  DrugEntity({
    this.drugId,
    required this.name,
    required this.dosage,
    required this.frequency,
    this.startDate,
    this.endDate,
    required this.drugStatus,
    this.isNew = false,
  });
}
