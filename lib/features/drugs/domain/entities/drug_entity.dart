// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:doclib/features/drugs/domain/entities/drug_status_enum.dart';

class DrugEntity {
  final String? id;
  final String drugName;
  final int frequency;
  final String? patienId;
  final String? dosage;
  final DateTime? startDate;
  final DateTime? endDate;
  final DrugStatusEnum? drugStatus;
  final String? drugId;
  DrugEntity({
    this.id,
    required this.drugName,
    required this.frequency,
    this.patienId,
    this.drugId,
    this.dosage,
    this.startDate,
    this.endDate,
    this.drugStatus,
  });
}
