import 'package:flutter/material.dart';
import 'photo_repository.dart';
import 'photo_object.dart';
import 'package:surf_flutter_summer_school_24/photo/request/photo_request.dart';

class PhotoController with ChangeNotifier {
  List<PhotoObject>? photos;

  Future<void> loadPhotos() async {
    photos = await PhotoRepository().getPhotos();
    notifyListeners();
  }

  Future<void> uploadImage() async {
    await uploadImageToYandexCloud();
    await loadPhotos();
  }
}
