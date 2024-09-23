import 'dart:convert';

class Album {
  final int? userId;
  final int? id;
  final String? title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(String str) => Album.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Album.fromMap(Map<String, dynamic> json) => Album(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
