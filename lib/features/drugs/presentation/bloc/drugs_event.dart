part of 'drugs_bloc.dart';

sealed class DrugsEvent extends Equatable {
  const DrugsEvent();

  @override
  List<Object> get props => [];
}

class GetCommonDrugs extends DrugsEvent {}
