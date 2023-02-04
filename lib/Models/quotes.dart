import 'dart:convert';

List<Quotes> quotesFromJson(String str) =>
    List<Quotes>.from(json.decode(str).map((x) => Quotes.fromJson(x)));

String quotesToJson(List<Quotes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quotes {
  Quotes({
    required this.id,
    required this.author,
    required this.content,
    required this.tags,
    required this.authorSlug,
    required this.length,
    required this.dateAdded,
    required this.dateModified,
  });

  String id;
  String author;
  String content;
  List<Tag> tags;
  String authorSlug;
  int length;
  DateTime dateAdded;
  DateTime dateModified;

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        id: json["_id"],
        author: json["author"],
        content: json["content"],
        tags: List<Tag>.from(json["tags"].map((x) => tagValues.map[x]!)),
        authorSlug: json["authorSlug"],
        length: json["length"],
        dateAdded: DateTime.parse(json["dateAdded"]),
        dateModified: DateTime.parse(json["dateModified"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "author": author,
        "content": content,
        "tags": List<dynamic>.from(tags.map((x) => tagValues.reverse[x])),
        "authorSlug": authorSlug,
        "length": length,
        "dateAdded":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "dateModified":
            "${dateModified.year.toString().padLeft(4, '0')}-${dateModified.month.toString().padLeft(2, '0')}-${dateModified.day.toString().padLeft(2, '0')}",
      };
}

enum Tag { SPORTS, COMPETITION, HUMOROUS }

final tagValues = EnumValues({
  "competition": Tag.COMPETITION,
  "humorous": Tag.HUMOROUS,
  "sports": Tag.SPORTS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
