class ChapterDetails {
  ChapterDetails({
    this.id,
    this.header,
    this.slug,
    this.body,
    this.viewCount,
    this.uploadDate,
    this.updatedDate,
    this.deletedAt,
    this.story,
  });

  int? id;
  String? header;
  String? slug;
  List<String>? body;
  int? viewCount;
  DateTime? uploadDate;
  DateTime? updatedDate;
  dynamic deletedAt;
  Story? story;

  factory ChapterDetails.fromJson(Map<String, dynamic> json) => ChapterDetails(
    id: json["id"],
    header: json["header"],
    slug: json["slug"],
    body: List<String>.from(json["body"].map((x) => x)),
    viewCount: json["viewCount"],
    uploadDate: DateTime.parse(json["uploadDate"]),
    updatedDate: DateTime.parse(json["updatedDate"]),
    deletedAt: json["deletedAt"],
    story: Story.fromJson(json["story"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "header": header,
    "slug": slug,
    "body": List<dynamic>.from(body!.map((x) => x)),
    "viewCount": viewCount,
    "uploadDate": uploadDate!.toIso8601String(),
    "updatedDate": updatedDate!.toIso8601String(),
    "deletedAt": deletedAt,
    "story": story!.toJson(),
  };
}

class Story {
  Story({
    this.id,
    this.title,
    this.author,
    this.slug,
    this.description,
    this.poster,
    this.categoryList,
    this.status,
    this.uploadDate,
    this.updatedDate,
    this.deletedAt,
  });

  int? id;
  String? title;
  String? author;
  String? slug;
  List<String>? description;
  String? poster;
  List<String>? categoryList;
  String? status;
  DateTime? uploadDate;
  DateTime? updatedDate;
  dynamic deletedAt;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    title: json["title"],
    author: json["author"],
    slug: json["slug"],
    description: List<String>.from(json["description"].map((x) => x)),
    poster: json["poster"],
    categoryList: List<String>.from(json["categoryList"].map((x) => x)),
    status: json["status"],
    uploadDate: DateTime.parse(json["uploadDate"]),
    updatedDate: DateTime.parse(json["updatedDate"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "author": author,
    "slug": slug,
    "description": List<dynamic>.from(description!.map((x) => x)),
    "poster": poster,
    "categoryList": List<dynamic>.from(categoryList!.map((x) => x)),
    "status": status,
    "uploadDate": uploadDate!.toIso8601String(),
    "updatedDate": updatedDate!.toIso8601String(),
    "deletedAt": deletedAt,
  };
}