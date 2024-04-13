import 'dart:convert';
import 'package:photo_fetch/models/models.dart';
import 'package:photo_fetch/resources/resources.dart';
import 'package:http/http.dart' as http;

class FetchPhoto {
  static Future<List<Photo>> getPhotos() async {
    final Uri uri = Uri.parse(AppValues.photoApiUrl);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;
      final photos = body
          .map((json) => Photo.fromJson(json as Map<String, dynamic>))
          .toList();

      return photos;
    } else {
      throw Exception();
    }
  }

  static Future<Photo> updatePhoto(
    Photo photo,
  ) async {
    final Uri uri = Uri.parse('${AppValues.photoApiUrl}/${photo.id}');
    final response = await http.put(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(photo.toMap()));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final photo = Photo.fromJson(body as Map<String, dynamic>);
      return photo;
    } else {
      throw Exception();
    }
  }

  static Future<Photo> deletePhoto(
    Photo photo,
  ) async {
    final Uri uri = Uri.parse('${AppValues.photoApiUrl}/${photo.id}');
    final response = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final photo = Photo.fromJson(body as Map<String, dynamic>);
      return photo;
    } else {
      throw Exception();
    }
  }

  static Future<Photo> addPhoto(
    Photo photo,
  ) async {
    final Uri uri = Uri.parse(AppValues.photoApiUrl);
    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(photo.toMap()));
    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final photo = Photo.fromJson(body as Map<String, dynamic>);
      return photo;
    } else {
      throw Exception();
    }
  }
}
