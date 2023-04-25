import '../../../../apiResponse/Chapter.dart';

abstract class ChapterState {
  final List<Chapter> chapters;

  ChapterState({required this.chapters});
}

class ChapterLoadingState extends ChapterState {
  ChapterLoadingState({required super.chapters});
}

class ChapterLoadedState extends ChapterState {
  ChapterLoadedState({required super.chapters});
}
