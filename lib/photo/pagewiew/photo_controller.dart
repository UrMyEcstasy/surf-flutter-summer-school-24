import 'package:flutter/foundation.dart';
import '../request/photo_request.dart';
import '../pagewiew/photo_object.dart';
import '../pagewiew/photo_repository.dart';

class PhotoController extends ChangeNotifier {
  List<PhotoObject>? photos;

  PhotoController() {
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    await fillRepository();
    photos = await PhotoRepository().getPhotos();
    notifyListeners();
  }
  Future<void> uploadImage() async {
    await uploadImageToYandexCloud();
    await _loadPhotos();
  }
}