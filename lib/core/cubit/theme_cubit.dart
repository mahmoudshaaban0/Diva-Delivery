import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limitless_code_template/core/constants/app_constants.dart';
import 'package:limitless_code_template/core/storage/key_value_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._storage) : super(_read(_storage));

  final KeyValueStorage _storage;

  static ThemeMode _read(KeyValueStorage storage) {
    final saved = storage.getString(AppConstants.themeModeKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == saved,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(mode);
    await _storage.setString(AppConstants.themeModeKey, mode.name);
  }

  Future<void> setDarkMode({required bool isDark}) =>
      setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
}
