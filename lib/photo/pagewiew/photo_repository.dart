import 'photo_object.dart';

class PhotoRepository {
  static final PhotoRepository _singleton = PhotoRepository._internal();
  List<PhotoObject> _photos = [];

  factory PhotoRepository() {
    return _singleton;
  }

  PhotoRepository._internal();

  void addPhotos(List<String> urls) {
    for (String url in urls) {
      _photos.add(PhotoObject(url: url, createdAt: DateTime.now()));
    }
  }

  Future<List<PhotoObject>> getPhotos() async {
    return _photos;
  }
}
