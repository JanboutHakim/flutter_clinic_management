import 'package:doclib/features/drugs/domain/entities/Drug_common_entity.dart';
import 'package:flutter/material.dart';

class CommonDrugCard extends StatelessWidget {
  final DrugCommonEntity drug;

  const CommonDrugCard({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(drug.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text("Scientific: ${drug.scientificName}"),
            Text("Dosage: ${drug.medicationDosage}"),
            Text("Form: ${drug.pharmaceuticalForm}"),
            Text("Company: ${drug.company}"),
          ],
        ),
      ),
    );
  }
}
