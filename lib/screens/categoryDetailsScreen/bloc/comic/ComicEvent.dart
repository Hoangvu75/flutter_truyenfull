abstract class ComicEvent {
  const ComicEvent({required this.categoryId});
  final int categoryId;
}

class LoadComicEvent extends ComicEvent {
  LoadComicEvent({required super.categoryId});
}

class LoadMoreComicEvent extends ComicEvent {
  LoadMoreComicEvent({required super.categoryId});
}