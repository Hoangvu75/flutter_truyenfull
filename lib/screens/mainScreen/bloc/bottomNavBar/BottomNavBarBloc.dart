import 'package:bloc/bloc.dart';

import 'BottomNavBarEvent.dart';
import 'BottomNavBarState.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(BottomNavBarInitialState()) {
    on<BottomNavBarEvent>((event, emit) {
      emit(BottomNavBarState(position: event.position));
    });
  }
}
