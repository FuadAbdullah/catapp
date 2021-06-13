import 'dart:convert';

class CatPhoto {
  final String id;
  final String url;
  final int width;
  final int height;

  const CatPhoto({required this.id, required this.url, required this.width, required this.height});

  Map<String, dynamic> toMap() {
    return {'id': id, 'url': url, 'width': width, 'height': height};
  }

  static CatPhoto fromMap(Map<String, dynamic> map) {
    return CatPhoto(
        id: map['id'],
        url: map['url'],
        width: map['width'],
        height: map['height']);
  }

  String toJson() => json.encode(toMap());

  static CatPhoto fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'CatPhoto(id: $id, url: $url, width: $width, height: $height)';
  }
}
