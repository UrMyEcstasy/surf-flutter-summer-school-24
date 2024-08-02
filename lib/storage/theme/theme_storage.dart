import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  final SharedPreferences prefs;
  static const String _themeModeKey = 'themeMode';

  ThemeStorage({required this.prefs});

  bool? getThemeMode() {
    return prefs.getBool(_themeModeKey);
  }

  Future<void> setThemeMode(bool isDarkMode) async {
    await prefs.setBool(_themeModeKey, isDarkMode);
  }
}
