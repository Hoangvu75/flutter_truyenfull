import 'package:flutter_truyenfull/apiResponse/Chapter.dart';

import '../../../apiService/ApiService.dart';

class ChaptersRepository {
  Future<List<Chapter>> getChapters(String slug) async {
    final response = await ApiService.create().getChaptersOfComic(slug);
    final List<Chapter> chapters = response;
    return chapters;
  }
}