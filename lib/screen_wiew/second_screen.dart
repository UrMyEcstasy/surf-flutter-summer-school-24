import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../photo/pagewiew/photo_controller.dart';

class SecondScreen extends StatelessWidget {
  final int initialIndex;

  const SecondScreen({required this.initialIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoController = Provider.of<PhotoController>(context);
    final photos = photoController.photos;

    if (photos == null || photos.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('No photos'),
        ),
        body: Center(
          child: Text('No photos available'),
        ),
      );
    }

    final PageController pageController = PageController(initialPage: initialIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          photos[initialIndex].createdAt != null
              ? DateFormat('dd.MM.yyyy').format(photos[initialIndex].createdAt!)
              : 'No date',
        ),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(photos[index].url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '${index + 1} / ${photos.length}', // Отображение позиции изображения среди всех
                style: TextStyle(fontSize: 16),
              ),
            ],
          );
        },
      ),
    );
  }
}
