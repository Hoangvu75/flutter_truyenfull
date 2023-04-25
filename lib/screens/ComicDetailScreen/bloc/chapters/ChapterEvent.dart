abstract class ChapterEvent {}

class LoadChapterEvent extends ChapterEvent {
  final String slug;

  LoadChapterEvent({required this.slug});
}