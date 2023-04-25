import 'package:bloc/bloc.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/bloc/settings/SettingsEvent.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/bloc/settings/SettingsState.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(CurrentSettingsState(fontSize: 18, isDarkMode: false, isScrollView: true)) {
    on<ChangeSettingsEvent>(
      (event, emit) async {
        emit(CurrentSettingsState(
          fontSize: event.fontSize == null ? state.fontSize : event.fontSize!,
          isDarkMode: event.isDarkMode == null ? state.isDarkMode : event.isDarkMode!,
          isScrollView: event.isScrollView == null ? state.isScrollView : event.isScrollView!,
        ));
      },
    );
  }
}
