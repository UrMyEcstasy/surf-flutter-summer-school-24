import '/feature/theme/di/theme_inherited.dart';
import 'package:flutter/material.dart';


class ThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeMode themeMode) builder;

  const ThemeBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeInherited.of(context).themeController;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController.themeMode,
      builder: (context, themeMode, child) {
        return builder(context, themeMode);
      },
    );
  }
}
