import 'package:flutter_truyenfull/apiResponse/ComicDetails.dart';

abstract class ComicDetailsState {
  final ComicDetails? comicDetails;

  ComicDetailsState(this.comicDetails);
}

class ComicDetailsLoadingState extends ComicDetailsState {
  ComicDetailsLoadingState(super.comicDetails);
}

class ComicDetailsLoadedState extends ComicDetailsState {
  ComicDetailsLoadedState(super.comicDetails);
}
