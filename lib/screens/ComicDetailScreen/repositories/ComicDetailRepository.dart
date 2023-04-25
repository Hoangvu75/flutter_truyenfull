import 'package:flutter_truyenfull/apiResponse/ComicDetails.dart';

import '../../../apiService/ApiService.dart';

class ComicDetailsRepository {
  Future<ComicDetails> getComicDetailsById(int id) async {
    final response = await ApiService.create().getComicDetailsById(id);
    final ComicDetails comicDetails = response;
    return comicDetails;
  }
}