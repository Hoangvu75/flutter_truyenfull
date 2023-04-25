abstract class ChapterDetailsEvent {}

class LoadChapterDetailsEvent extends ChapterDetailsEvent {
  final int id;

  LoadChapterDetailsEvent({required this.id});
}