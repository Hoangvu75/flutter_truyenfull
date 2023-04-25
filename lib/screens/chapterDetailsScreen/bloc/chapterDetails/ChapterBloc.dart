import 'package:bloc/bloc.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/bloc/chapterDetails/ChapterDetailsEvent.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/bloc/chapterDetails/ChapterDetailsState.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/repositories/ChapterDetailsRepositories.dart';

class ChapterDetailsBloc extends Bloc<ChapterDetailsEvent, ChapterDetailsState> {
  late final ChapterDetailsRepository _chaptersDetailsRepository;

  ChapterDetailsBloc(this._chaptersDetailsRepository) : super(ChapterDetailsLoadingState(chapterDetails: null)) {
    on<LoadChapterDetailsEvent>((event, emit) async {
      emit(ChapterDetailsLoadingState(chapterDetails: null));

      final chapterDetailsFromApi = await _chaptersDetailsRepository.getChapterDetails(event.id);

      emit(ChapterDetailsLoadedState(chapterDetails: chapterDetailsFromApi));
    });
  }
}