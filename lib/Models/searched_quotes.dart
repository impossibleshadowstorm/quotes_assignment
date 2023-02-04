import 'dart:convert';

List<AuthorBasedSearchQuotes> searchedQuotesFromJson(String str) =>
    List<AuthorBasedSearchQuotes>.from(
        json.decode(str).map((x) => AuthorBasedSearchQuotes.fromJson(x)));

String searchedQuotesToJson(List<AuthorBasedSearchQuotes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthorBasedSearchQuotes {
  AuthorBasedSearchQuotes({
    required this.id,
    required this.content,
    required this.author,
    required this.tags,
    required this.authorId,
    required this.authorSlug,
    required this.length,
    required this.dateAdded,
    required this.dateModified,
  });

  String id;
  String content;
  String author;
  List<String> tags;
  String authorId;
  String authorSlug;
  int length;
  String dateAdded;
  String dateModified;

  factory AuthorBasedSearchQuotes.fromJson(Map<String, dynamic> json) =>
      AuthorBasedSearchQuotes(
        id: json["_id"],
        content: json["content"],
        author: json["author"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        authorId: json["authorId"],
        authorSlug: json["authorSlug"],
        length: json["length"],
        dateAdded: json["dateAdded"],
        dateModified: json["dateModified"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "author": author,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "authorId": authorId,
        "authorSlug": authorSlug,
        "length": length,
        "dateAdded": dateAdded,
        "dateModified": dateModified,
      };
}
