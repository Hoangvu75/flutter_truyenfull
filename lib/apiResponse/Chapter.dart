class Chapter {
  Chapter({
    this.id,
    this.header,
    this.slug,
    this.viewCount,
    this.updatedDate,
    this.story,
  });

  int? id;
  String? header;
  String? slug;
  int? viewCount;
  DateTime? updatedDate;
  Story? story;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json["id"],
    header: json["header"],
    slug: json["slug"],
    viewCount: json["viewCount"],
    updatedDate: DateTime.parse(json["updatedDate"]),
    story: Story.fromJson(json["story"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "header": header,
    "slug": slug,
    "viewCount": viewCount,
    "updatedDate": updatedDate!.toIso8601String(),
    "story": story!.toJson(),
  };
}

class Story {
  Story({
    this.id,
    this.slug,
  });

  int? id;
  String? slug;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
  };
}