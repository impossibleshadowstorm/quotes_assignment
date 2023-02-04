import 'dart:convert';

List<Author> authorFromJson(String str) =>
    List<Author>.from(json.decode(str).map((x) => Author.fromJson(x)));

String authorToJson(List<Author> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Author {
  Author({
    required this.id,
    required this.name,
    required this.bio,
    required this.description,
    required this.link,
    required this.quoteCount,
    required this.slug,
    required this.dateAdded,
    required this.dateModified,
  });

  String id;
  String name;
  String bio;
  String description;
  String link;
  int quoteCount;
  String slug;
  DateTime dateAdded;
  DateTime dateModified;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["_id"],
        name: json["name"],
        bio: json["bio"],
        description: json["description"],
        link: json["link"],
        quoteCount: json["quoteCount"],
        slug: json["slug"],
        dateAdded: DateTime.parse(json["dateAdded"]),
        dateModified: DateTime.parse(json["dateModified"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "bio": bio,
        "description": description,
        "link": link,
        "quoteCount": quoteCount,
        "slug": slug,
        "dateAdded":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "dateModified":
            "${dateModified.year.toString().padLeft(4, '0')}-${dateModified.month.toString().padLeft(2, '0')}-${dateModified.day.toString().padLeft(2, '0')}",
      };
}
