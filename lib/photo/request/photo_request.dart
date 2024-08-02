import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:surf_flutter_summer_school_24/photo/pagewiew/photo_repository.dart';

const token = 'y0_AgAAAABjio2uAADLWwAAAAELposoAAA-lxErBH9EurwONGIN7REkRLxcQA';

Future<void> uploadImageToYandexCloud() async {
  final picker = ImagePicker();
  final imageFromGallery = await picker.pickImage(source: ImageSource.gallery);
  if (imageFromGallery == null) return;

  final name = imageFromGallery.name;

  final uri = Uri.https(
    'cloud-api.yandex.net',
    'v1/disk/resources/upload',
    {
      "path": name,
    },
  );

  final response = await http.get(
    uri,
    headers: {
      HttpHeaders.authorizationHeader: 'OAuth $token',
    },
  );

  final body = response.body;
  final json = jsonDecode(body);
  final linkToUpload = json['href'] as String;

  final dio = Dio();
  final file = File(imageFromGallery.path);
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file.path),
  });
  await dio.put(linkToUpload, data: formData);
}

Future<void> fillRepository() async {
  final uri = Uri.https(
    'cloud-api.yandex.net',
    'v1/disk/resources/files',
  );

  final response = await http.get(
    uri,
    headers: {
      HttpHeaders.authorizationHeader: 'OAuth $token',
    },
  );

  final map = jsonDecode(response.body) as Map<String, dynamic>;
  final mapItems = map['items'] as List<dynamic>;
  mapItems.removeWhere((element) => element['media_type'] != 'image');
  final files = mapItems.map((element) => element['file'] as String).toList();

  final repository = PhotoRepository();
  repository.addPhotos(files);
}