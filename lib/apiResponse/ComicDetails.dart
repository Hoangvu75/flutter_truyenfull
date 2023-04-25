class ComicDetails {
  ComicDetails({
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
    this.raters,
    this.ratings,
    this.categories,
    this.bookmarks,
    this.comments,
    this.rateCount,
    this.rateAvg,
    this.favorite,
    this.latestUpdatedDate,
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
  List<Rater>? raters;
  List<Rating>? ratings;
  List<ComicDetailsCategory>? categories;
  List<Bookmark>? bookmarks;
  List<Comment>? comments;
  int? rateCount;
  int? rateAvg;
  Favorite? favorite;
  DateTime? latestUpdatedDate;

  factory ComicDetails.fromJson(Map<String, dynamic> json) => ComicDetails(
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
    raters: List<Rater>.from(json["raters"].map((x) => Rater.fromJson(x))),
    ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
    categories: List<ComicDetailsCategory>.from(json["categories"].map((x) => ComicDetailsCategory.fromJson(x))),
    bookmarks: List<Bookmark>.from(json["bookmarks"].map((x) => Bookmark.fromJson(x))),
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    rateCount: json["rateCount"],
    rateAvg: json["rateAvg"],
    favorite: Favorite.fromJson(json["favorite"]),
    latestUpdatedDate: DateTime.parse(json["latestUpdatedDate"]),
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
    "raters": List<dynamic>.from(raters!.map((x) => x.toJson())),
    "ratings": List<dynamic>.from(ratings!.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    "bookmarks": List<dynamic>.from(bookmarks!.map((x) => x.toJson())),
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
    "rateCount": rateCount,
    "rateAvg": rateAvg,
    "favorite": favorite!.toJson(),
    "latestUpdatedDate": latestUpdatedDate!.toIso8601String(),
  };
}

class Bookmark {
  Bookmark({
    this.id,
    this.updatedDate,
  });

  int? id;
  DateTime? updatedDate;

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
    id: json["id"],
    updatedDate: DateTime.parse(json["updatedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updatedDate": updatedDate!.toIso8601String(),
  };
}

class ComicDetailsCategory {
  ComicDetailsCategory({
    this.id,
    this.name,
    this.slug,
    this.description,
  });

  int? id;
  String? name;
  String? slug;
  String? description;

  factory ComicDetailsCategory.fromJson(Map<String, dynamic> json) => ComicDetailsCategory(
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

class Comment {
  Comment({
    this.id,
    this.content,
    this.parentId,
    this.updatedDate,
    this.deletedAt,
    this.replies,
    this.user,
  });

  int? id;
  String? content;
  int? parentId;
  DateTime? updatedDate;
  dynamic deletedAt;
  List<Comment>? replies;
  Rater? user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    content: json["content"],
    parentId: json["parentId"],
    updatedDate: DateTime.parse(json["updatedDate"]),
    deletedAt: json["deletedAt"],
    replies: List<Comment>.from(json["replies"].map((x) => Comment.fromJson(x))),
    user: Rater.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "parentId": parentId,
    "updatedDate": updatedDate!.toIso8601String(),
    "deletedAt": deletedAt,
    "replies": List<dynamic>.from(replies!.map((x) => x.toJson())),
    "user": user!.toJson(),
  };
}

class Rater {
  Rater({
    this.id,
    this.email,
    this.name,
    this.roles,
    this.permissions,
    this.avatarFilePath,
    this.isEmailConfirmed,
    this.updatedDate,
    this.deletedAt,
  });

  int? id;
  String? email;
  String? name;
  List<String>? roles;
  List<dynamic>? permissions;
  String? avatarFilePath;
  bool? isEmailConfirmed;
  DateTime? updatedDate;
  dynamic deletedAt;

  factory Rater.fromJson(Map<String, dynamic> json) => Rater(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
    avatarFilePath: json["avatarFilePath"],
    isEmailConfirmed: json["isEmailConfirmed"],
    updatedDate: DateTime.parse(json["updatedDate"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "roles": List<dynamic>.from(roles!.map((x) => x)),
    "permissions": List<dynamic>.from(permissions!.map((x) => x)),
    "avatarFilePath": avatarFilePath,
    "isEmailConfirmed": isEmailConfirmed,
    "updatedDate": updatedDate!.toIso8601String(),
    "deletedAt": deletedAt,
  };
}

class Favorite {
  Favorite({
    this.count,
    this.isFavorite,
  });

  int? count;
  bool? isFavorite;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    count: json["count"],
    isFavorite: json["isFavorite"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "isFavorite": isFavorite,
  };
}

class Rating {
  Rating({
    this.id,
    this.value,
  });

  int? id;
  int? value;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
  };
}