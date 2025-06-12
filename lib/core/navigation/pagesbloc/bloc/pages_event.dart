part of 'pages_bloc.dart';

sealed class PagesEvent extends Equatable {
  const PagesEvent();

  @override
  List<Object> get props => [];
}

class PageEvent extends PagesEvent {
  final int index;
  const PageEvent({required this.index});
  @override
  List<Object> get props => [index];
}
