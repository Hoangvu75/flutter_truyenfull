import 'package:bloc/bloc.dart';

import '../../../../apiResponse/Comic.dart';
import '../../repositories/UpdatedComicRepository.dart';
import 'UpdatedComicEvent.dart';
import 'UpdatedComicState.dart';

class UpdatedComicBloc extends Bloc<UpdatedComicEvent, UpdatedComicState> {
  late final UpdatedComicRepository _updatedComicRepository;
  int page = 1;
  List<Comic> comicList = [];

  UpdatedComicBloc(this._updatedComicRepository) : super(UpdatedComicLoadingState([])) {
    on<LoadUpdatedComicEvent>((event, emit) async {
      emit(UpdatedComicLoadingState([]));

      final comicsFromApi = await _updatedComicRepository.getUpdatedComic(1, page);
      comicList.addAll(comicsFromApi);

      emit(UpdatedComicLoadedState(comicList));
      page++;
    });

    on<LoadMoreUpdatedComicEvent>((event, emit) async {
      final comicsFromApi = await _updatedComicRepository.getUpdatedComic(1, page);
      comicList.addAll(comicsFromApi);

      emit(UpdatedComicLoadedState(comicList));
      page++;
    });
  }
}