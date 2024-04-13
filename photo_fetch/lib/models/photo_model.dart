import 'package:photo_fetch/resources/resources.dart';

class Photo {
  String title;
  String url;
  int? id;

  Photo({required this.title, required this.url, this.id});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        title: json['title'] ?? AppStrings.deletedPhotoTitle,
        url: json['url'] ?? AppStrings.deletedPhotoUrl,
        id: json['id']);
  }
  Map<String, String> toMap() {
    return {'title': title, 'url': url};
  }
}
