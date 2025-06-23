import 'dart:developer';

import 'package:doclib/core/Di/di.dart';
import 'package:doclib/features/drugs/presentation/bloc/drugs_bloc.dart';
import 'package:doclib/features/drugs/presentation/widgets/list_of_common_drugs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrugsPages extends StatefulWidget {
  const DrugsPages({super.key});

  @override
  State<DrugsPages> createState() => _DrugsPagesState();
}

class _DrugsPagesState extends State<DrugsPages> {
  @override
  Widget build(BuildContext context) {
    // return Center(child: Text("this is drugs page"));
    return BlocProvider<DrugsBloc>(
      create: (context) => getIt<DrugsBloc>()..add(GetCommonDrugs()),
      child: Builder(
        builder:
            (_) => BlocBuilder<DrugsBloc, DrugsState>(
              builder: (context, state) {
                log(state.runtimeType.toString());
                if (state is DrugLoading) {
                  return Center(child: LinearProgressIndicator());
                } else if (state is DrugSuccess) {
                  return DrugListView(drugs: state.drugs);
                } else if (state is DrugFaild) {
                  return Text(state.failure.message);
                } else {
                  return Center(child: const Text('error'));
                }
              },
            ),
      ),
    );
  }
}
