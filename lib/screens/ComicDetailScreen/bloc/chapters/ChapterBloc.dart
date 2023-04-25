import 'package:bloc/bloc.dart';
import 'package:flutter_truyenfull/screens/ComicDetailScreen/bloc/chapters/ChapterEvent.dart';
import 'package:flutter_truyenfull/screens/ComicDetailScreen/bloc/chapters/ChapterState.dart';
import 'package:flutter_truyenfull/screens/ComicDetailScreen/repositories/ChaptersRepository.dart';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  late final ChaptersRepository _chaptersRepository;

  ChapterBloc(this._chaptersRepository) : super(ChapterLoadingState(chapters: [])) {
    on<LoadChapterEvent>((event, emit) async {
      emit(ChapterLoadingState(chapters: []));

      final chaptersFromApi = await _chaptersRepository.getChapters(event.slug);

      emit(ChapterLoadedState(chapters: chaptersFromApi));
    });
  }
}