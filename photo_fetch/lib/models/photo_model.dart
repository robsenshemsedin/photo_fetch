class Photo {
  String title;
  String url;
  final int id;

  Photo({required this.title, required this.url, required this.id});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(title: json['title'], url: json['url'], id: json['id']);
  }
  Map<String, String> toMap() {
    return {'title': title, 'url': url};
  }
}
