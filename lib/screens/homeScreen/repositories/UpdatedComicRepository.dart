import '../../../apiResponse/Comic.dart';
import '../../../apiService/ApiService.dart';

class UpdatedComicRepository {
  Future<List<Comic>> getUpdatedComic(int id, int page) async {
    final response = await ApiService.create().getComicsByCategory(id, page);
    final List<Comic> comics = response;
    return comics;
  }
}