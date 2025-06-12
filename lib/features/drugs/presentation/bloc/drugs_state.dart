part of 'drugs_bloc.dart';

sealed class DrugsState extends Equatable {
  const DrugsState();
  
  @override
  List<Object> get props => [];
}

final class DrugsInitial extends DrugsState {}
