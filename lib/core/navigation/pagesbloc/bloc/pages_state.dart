part of 'pages_bloc.dart';

class PagesState extends Equatable {
  final String title;
  final int index;
  const PagesState({required this.index, required this.title});

  @override
  List<Object> get props => [title, index];
}

// final class Pages extends PagesState {

//   const Pages();
// }

// final class HomePage extends PagesState {}

// final class DocumentsPage extends PagesState {}

// final class DrugsPage extends PagesState {}

// final class AcountPage extends PagesState {}

// final class AppointmentsPage extends PagesState {}
