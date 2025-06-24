import 'package:bloc/bloc.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/auth/domain/usecases/get_cached_user.dart';
import 'package:doclib/features/drugs/domain/entities/Drug_common_entity.dart';
import 'package:doclib/features/drugs/domain/usecases/get_common_drugs.dart';
import 'package:equatable/equatable.dart';

part 'drugs_event.dart';
part 'drugs_state.dart';

class DrugsBloc extends Bloc<DrugsEvent, DrugsState> {
  DrugsBloc({required this.getCommonDrugsUseCase}) : super(DrugsInitial()) {
    on<GetCommonDrugs>(_getCommonDrugs);
  }
  final GetCommonDrugsUseCase getCommonDrugsUseCase;

  Future<void> _getCommonDrugs(
    GetCommonDrugs event,
    Emitter<DrugsState> emit,
  ) async {
    emit(DrugLoading());
    final res = await getCommonDrugsUseCase();
    res.fold((l) => emit(DrugFailed(l)), (r) => emit(DrugSuccess(drugs: r)));
  }
}
