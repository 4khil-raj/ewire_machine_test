import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';

  ThemeBloc() : super(ThemeState(ThemeMode.system)) {
    on<LoadThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final modeIndex = prefs.getInt(_themeKey) ?? 0;
      emit(ThemeState(ThemeMode.values[modeIndex]));
    });

    on<ToggleThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      ThemeMode nextMode;
      if (state.themeMode == ThemeMode.light) {
        nextMode = ThemeMode.dark;
      } else if (state.themeMode == ThemeMode.dark) {
        nextMode = ThemeMode.light;
      } else {
        final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        nextMode = brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
      }
      await prefs.setInt(_themeKey, nextMode.index);
      emit(ThemeState(nextMode));
    });
  }
}

abstract class ThemeEvent {}
class LoadThemeEvent extends ThemeEvent {}
class ToggleThemeEvent extends ThemeEvent {}

class ThemeState {
  final ThemeMode themeMode;
  ThemeState(this.themeMode);
}
