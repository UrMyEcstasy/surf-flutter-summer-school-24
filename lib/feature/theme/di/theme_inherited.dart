import '/feature/theme/domain/theme_controller.dart';
import 'package:flutter/material.dart';

class ThemeInherited extends InheritedWidget {
  final ThemeController themeController;

  const ThemeInherited({
    super.key,
    required this.themeController,
    required Widget child,
  }) : super(child: child);

  static ThemeInherited of(BuildContext context) {
    final ThemeInherited? result =
    context.dependOnInheritedWidgetOfExactType<ThemeInherited>();
    assert(result != null, 'No ThemeInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant ThemeInherited oldWidget) {
    return themeController != oldWidget.themeController;
  }
}