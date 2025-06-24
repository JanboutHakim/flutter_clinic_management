part of 'drugs_bloc.dart';

sealed class DrugsState extends Equatable {
  const DrugsState();

  @override
  List<Object> get props => [];
}

final class DrugsInitial extends DrugsState {}

final class DrugLoading extends DrugsState {}

final class DrugFailed extends DrugsState {
  final Failure failure;
  const DrugFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

final class DrugSuccess extends DrugsState {
  final List<DrugCommonEntity> drugs;
  const DrugSuccess({required this.drugs});
  @override
  // TODO: implement props
  List<Object> get props => [drugs];
}
