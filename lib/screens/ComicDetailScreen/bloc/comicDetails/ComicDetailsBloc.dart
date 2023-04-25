import 'package:bloc/bloc.dart';
import 'package:flutter_truyenfull/screens/ComicDetailScreen/repositories/ComicDetailRepository.dart';

import 'ComicDetailsEvent.dart';
import 'ComicDetailsState.dart';

class ComicDetailsBloc extends Bloc<ComicDetailsEvent, ComicDetailsState> {
  late final ComicDetailsRepository _comicDetailsRepository;

  ComicDetailsBloc(this._comicDetailsRepository) : super(ComicDetailsLoadingState(null)) {
    on<LoadComicDetailsEvent>((event, emit) async {
      emit(ComicDetailsLoadingState(null));

      final comicsFromApi = await _comicDetailsRepository.getComicDetailsById(event.comicId);

      emit(ComicDetailsLoadedState(comicsFromApi));
    });

  }
}