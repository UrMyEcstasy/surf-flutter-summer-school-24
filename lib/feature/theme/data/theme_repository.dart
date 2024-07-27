import 'package:flutter/material.dart';
import '/storage/theme/theme_storage.dart';

class ThemeRepository {
  final ThemeStorage _themeStorage;

  ThemeRepository({required ThemeStorage themeStorage})
      : _themeStorage = themeStorage;

  ThemeMode? getThemeMode() {
    final isDarkMode = _themeStorage.getThemeMode();
    if (isDarkMode == null) return null;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _themeStorage.setThemeMode(themeMode == ThemeMode.dark);
  }
}
