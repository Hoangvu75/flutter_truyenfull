import 'package:bloc/bloc.dart';

import 'HeaderSelectorEvent.dart';
import 'HeaderSelectorState.dart';

class HeaderSelectorBloc extends Bloc<HeaderSelectorEvent, HeaderSelectorState> {
  HeaderSelectorBloc() : super(HeaderSelectorInitialState()) {
    on<HeaderSelectorEvent>((event, emit) {
      emit(HeaderSelectorState(position: event.position));
    });
  }
}
