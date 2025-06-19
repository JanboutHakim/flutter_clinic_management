import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pages_event.dart';
part 'pages_state.dart';

class PagesBloc extends Bloc<PagesEvent, PagesState> {
  PagesBloc() : super(PagesState(index: 0, title: "Home")) {
    on<PageEvent>((event, emit) {
      final List<String> titles = [
        "Home",
        "appointments",
        "Drugs",
        "Documents",
        "Account",
      ];

      emit(PagesState(index: event.index, title: titles[event.index]));
    });
  }
}
