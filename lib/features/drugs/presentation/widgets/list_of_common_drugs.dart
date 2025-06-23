import 'package:doclib/features/drugs/domain/entities/Drug_common_entity.dart';
import 'package:doclib/features/drugs/presentation/widgets/drug_common_widget.dart';
import 'package:flutter/material.dart';

class DrugListView extends StatelessWidget {
  final List<DrugCommonEntity> drugs;

  const DrugListView({super.key, required this.drugs});

  @override
  Widget build(BuildContext context) {
    if (drugs.isEmpty) {
      return const Center(child: Text("No drugs available."));
    }

    return ListView.builder(
      itemCount: drugs.length,
      itemBuilder: (context, index) {
        return CommonDrugCard(drug: drugs[index]);
      },
    );
  }
}
