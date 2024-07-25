import 'package:flutter/material.dart';
import 'theme_manager/theme_manager.dart';
import 'package:provider/provider.dart';
import 'second_screen.dart';

const String mainScreen = "assets/main_screen.jpg";

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CatsProfessions",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return _ThemeSwitcher();
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: GridView.builder(
          itemCount: workersCats.length,
          itemBuilder: (context, index) => ImageViewer(index),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final int imageIndex;

  const ImageViewer(this.imageIndex);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondScreen(initialIndex: imageIndex),
          ),
        );
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(workersCats[imageIndex]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _ThemeSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    bool _isDarkTheme = themeManager.themeMode == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: Text("Темная тема"),
            value: _isDarkTheme,
            onChanged: (value) {
              themeManager.toggleTheme(value);
            },
          ),
        ],
      ),
    );
  }
}
