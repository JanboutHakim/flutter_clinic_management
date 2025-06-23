import 'package:doclib/features/drugs/domain/entities/drug_entity.dart';
import 'package:doclib/features/drugs/domain/entities/drug_status_enum.dart';

///"drugs": [
///{
/// ```
///PatientDrugDto
///"id": 3,Sring
///"patientId": 101,String
///"drugId": 501,Long
///"frequency" : 2,int (required)
///"drugName": "Aspirin",String
///"dosage": "100mg",String
///"startDate": "2025-06-01",LocalDate
///"endDate": "2025-06-10",LocalDate
///"drugStatus": "ACTIVE",Enum: DrugStatus
///```
class DrugModel extends DrugEntity {
  DrugModel({
    super.id,
    super.patienId,
    required super.drugName,
    super.dosage,
    required super.frequency,
    super.drugStatus,
    super.drugId,
    super.startDate,
    super.endDate,
  });
  factory DrugModel.fromJson(Map<String, dynamic> json) {
    return DrugModel(
      id: json['id'],
      patienId: json['patientId'].toString(),
      drugName: json['drugName'].toString(),
      dosage: json['dosage'].toString(),
      frequency: int.parse(json['frequency'].toString()),
      drugStatus: DrugStatus.fromString(json['drugStatus']),
      drugId: json['drugId'].toString(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patienId,
      'drugId': drugId,
      'frequency': frequency,
      'drugName': drugName,
      'dosage': dosage,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'drugStatus': drugStatus?.displayName,
    };
  }
}
