import 'package:flutter_truyenfull/apiResponse/Comic.dart';

abstract class UpdatedComicState {
  final List<Comic> comics;

  UpdatedComicState(this.comics);
}

class UpdatedComicLoadingState extends UpdatedComicState {
  UpdatedComicLoadingState(super.comics);
}

class UpdatedComicLoadedState extends UpdatedComicState {
  UpdatedComicLoadedState(super.comics);
}
