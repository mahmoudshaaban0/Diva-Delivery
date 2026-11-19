import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limitless_code_template/core/constants/app_constants.dart';
import 'package:limitless_code_template/core/storage/key_value_storage.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._storage) : super(_read(_storage));

  final KeyValueStorage _storage;

  static Locale _read(KeyValueStorage storage) {
    final saved = storage.getString(AppConstants.localeKey);
    // The app is Arabic-first (the Figma design is RTL Arabic).
    return Locale(saved ?? AppConstants.english);
  }

  bool get isArabic => state.languageCode == AppConstants.arabic;

  Future<void> setLocale(Locale locale) async {
    emit(locale);
    await _storage.setString(AppConstants.localeKey, locale.languageCode);
  }

  Future<void> setArabic({required bool isArabic}) =>
      setLocale(Locale(isArabic ? AppConstants.arabic : AppConstants.english));
}
