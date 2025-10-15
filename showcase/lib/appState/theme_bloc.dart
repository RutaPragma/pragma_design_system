import 'package:bloc/bloc.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/appState/theme_event.dart';
import 'package:showcase/appState/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
    : super(ThemeState(themeData: lightTheme, isDarkMode: false)) {
    on<ToggleThemeEvent>((event, emit) {
      final newTheme = state.isDarkMode
          ? lightTheme
          : darkTheme;
      emit(ThemeState(themeData: newTheme, isDarkMode: !state.isDarkMode));
    });
  }
}
