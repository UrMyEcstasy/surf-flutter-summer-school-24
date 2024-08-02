import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../feature/theme/domain/theme_controller.dart';
import 'second_screen.dart';
import '../photo/pagewiew/photo_controller.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/di/theme_inherited.dart';
import 'error_screen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final photoController = Provider.of<PhotoController>(context);
    final photos = photoController.photos;

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
        child: photos == null
            ? CircularProgressIndicator()
            : GridView.builder(
          itemCount: photos.length,
          itemBuilder: (context, index) => ImageViewer(index, photos[index].url),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Provider.of<PhotoController>(context, listen: false).uploadImage();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.monetization_on),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ErrorScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final int imageIndex;
  final String imageUrl;

  const ImageViewer(this.imageIndex, this.imageUrl, {super.key});

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
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
