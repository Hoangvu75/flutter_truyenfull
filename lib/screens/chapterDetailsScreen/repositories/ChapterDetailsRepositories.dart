import 'package:flutter_truyenfull/apiResponse/ChapterDetails.dart';

import '../../../apiService/ApiService.dart';

class ChapterDetailsRepository {
  Future<ChapterDetails> getChapterDetails(int id) async {
    final response = await ApiService.create().getChapterDetails(id);
    final ChapterDetails chapterDetails = response;
    return chapterDetails;
  }
}