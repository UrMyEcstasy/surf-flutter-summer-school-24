import 'package:flutter/material.dart';
import 'theme_manager/theme_manager.dart';
import 'package:provider/provider.dart';
import 'first_screen.dart';
import 'second_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeManager.themeMode,
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => FirstScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/second') {
              final int index = settings.arguments as int;
              return MaterialPageRoute(
                builder: (context) {
                  return SecondScreen(initialIndex: index);
                },
              );
            }
            return null;
          },
        );
      },
    );
  }
}
