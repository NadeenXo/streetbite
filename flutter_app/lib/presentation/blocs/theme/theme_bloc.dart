import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.light)) {
    on<ToggleTheme>((event, emit) {
      final nextMode = state.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;

      emit(ThemeState(themeMode: nextMode));
    });
  }
}
