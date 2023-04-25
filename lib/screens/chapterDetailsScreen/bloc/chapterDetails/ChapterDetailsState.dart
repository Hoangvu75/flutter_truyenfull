import 'package:flutter_truyenfull/apiResponse/ChapterDetails.dart';

abstract class ChapterDetailsState {
  final ChapterDetails? chapterDetails;

  ChapterDetailsState({required this.chapterDetails});
}

class ChapterDetailsLoadingState extends ChapterDetailsState {
  ChapterDetailsLoadingState({required super.chapterDetails});
}

class ChapterDetailsLoadedState extends ChapterDetailsState {
  ChapterDetailsLoadedState({required super.chapterDetails});
}
