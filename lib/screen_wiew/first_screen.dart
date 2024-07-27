import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../feature/theme/di/theme_inherited.dart';
import '../photo/pagewiew/photo_controller.dart';
import 'second_screen.dart';
import 'error_screen.dart';

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
        child: Consumer<PhotoController>(
          builder: (context, controller, child) {
            if (controller.photos == null) {
              controller.loadPhotos();
              return CircularProgressIndicator();
            }
            return GridView.builder(
              itemCount: controller.photos!.length,
              itemBuilder: (context, index) => ImageViewer(index),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Provider.of<PhotoController>(context, listen: false).uploadImage();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final int imageIndex;

  const ImageViewer(this.imageIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    final photoController = Provider.of<PhotoController>(context, listen: false);
    final photo = photoController.photos![imageIndex];
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(photo.url),
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
    final themeController = ThemeInherited.of(context).themeController;
    final isDarkTheme = themeController.themeMode.value == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: Text("Темная тема"),
            value: isDarkTheme,
            onChanged: (value) {
              themeController.switchThemeMode();
            },
          ),
          ListTile(
            title: Text("Получить миллион"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ErrorScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

