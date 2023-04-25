abstract class ComicDetailsEvent {
  const ComicDetailsEvent({required this.comicId});
  final int comicId;
}

class LoadComicDetailsEvent extends ComicDetailsEvent {
  LoadComicDetailsEvent({required super.comicId});
}