import 'package:flutter_truyenfull/apiResponse/Comic.dart';

abstract class ComicState {
  final List<Comic> comics;

  ComicState(this.comics);
}

class ComicLoadingState extends ComicState {
  ComicLoadingState(super.comics);
}

class ComicLoadedState extends ComicState {
  ComicLoadedState(super.comics);
}
