import '../../../apiResponse/Comic.dart';
import '../../../apiService/ApiService.dart';

class ComicRepository {
  Future<List<Comic>> getComicByCategory(int id, int page) async {
    final response = await ApiService.create().getComicsByCategory(id, page);
    final List<Comic> comics = response;
    return comics;
  }
}