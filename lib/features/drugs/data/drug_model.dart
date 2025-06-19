import 'package:doclib/features/drugs/domain/drug_entity.dart';

class DrugModel extends DrugEntity {
  DrugModel({
    required super.name,
    required super.dosage,
    required super.frequency,
    required super.drugStatus,
    super.drugId,
    super.startDate,
    super.endDate,
    super.isNew,
  });
}
