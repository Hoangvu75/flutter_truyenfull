class Comic {
  Comic({
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

  factory Comic.fromJson(Map<String, dynamic> json) => Comic(
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

