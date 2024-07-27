import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../data/theme_repository.dart';

class ThemeController extends ChangeNotifier {
  final ThemeRepository _themeRepository;

  ThemeController({required ThemeRepository themeRepository})
      : _themeRepository = themeRepository {
    _themeMode = ValueNotifier<ThemeMode>(
      _themeRepository.getThemeMode() ?? ThemeMode.system,
    );
    _themeMode.addListener(notifyListeners);
  }

  late final ValueNotifier<ThemeMode> _themeMode;

  ValueListenable<ThemeMode> get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    if (newThemeMode == _themeMode.value) return;
    await _themeRepository.setThemeMode(newThemeMode);
    _themeMode.value = newThemeMode;
  }

  Future<void> switchThemeMode() async {
    final newThemeMode =
    _themeMode.value != ThemeMode.light ? ThemeMode.light : ThemeMode.dark;
    await _themeRepository.setThemeMode(newThemeMode);
    _themeMode.value = newThemeMode;
  }

  @override
  void dispose() {
    _themeMode.removeListener(notifyListeners);
    super.dispose();
  }
}
