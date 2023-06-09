class Category {
  Category({
    this.id,
    this.name,
    this.slug,
    this.description,
  });

  int? id;
  String? name;
  String? slug;
  String? description;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
  };
}