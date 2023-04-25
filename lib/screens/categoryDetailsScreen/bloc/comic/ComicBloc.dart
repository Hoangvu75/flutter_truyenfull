import 'package:bloc/bloc.dart';

import '../../../../apiResponse/Comic.dart';
import '../../repositories/ComicRepository.dart';
import 'ComicEvent.dart';
import 'ComicState.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  late final ComicRepository _comicRepository;
  int page = 1;
  List<Comic> comicList = [];

  ComicBloc(this._comicRepository) : super(ComicLoadingState([])) {
    on<LoadComicEvent>((event, emit) async {
      emit(ComicLoadingState([]));

      final comicsFromApi = await _comicRepository.getComicByCategory(event.categoryId, page);
      comicList.addAll(comicsFromApi);

      emit(ComicLoadedState(comicList));
      page++;
    });

    on<LoadMoreComicEvent>((event, emit) async {
      final comicsFromApi = await _comicRepository.getComicByCategory(event.categoryId, page);
      comicList.addAll(comicsFromApi);

      emit(ComicLoadedState(comicList));
      page++;
    });
  }
}