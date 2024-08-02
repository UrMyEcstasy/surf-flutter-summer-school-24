import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'feature/theme/domain/theme_controller.dart';
import 'feature/theme/di/theme_inherited.dart';
import 'screen_wiew/first_screen.dart';
import 'photo/pagewiew/photo_controller.dart';
import 'feature/theme/data/theme_repository.dart';
import 'storage/theme/theme_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final themeStorage = ThemeStorage(prefs: prefs);
  final themeRepository = ThemeRepository(themeStorage: themeStorage);
  final themeController = ThemeController(themeRepository: themeRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhotoController()),
        ChangeNotifierProvider(create: (_) => themeController),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, child) {
        return ThemeInherited(
          themeController: themeController,
          child: MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeController.themeMode.value,
            home: FirstScreen(),
          ),
        );
      },
    );
  }
}
