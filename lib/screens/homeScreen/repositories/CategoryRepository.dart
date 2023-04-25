import 'package:flutter_truyenfull/apiResponse/Category.dart';

import '../../../apiService/ApiService.dart';

class CategoryRepository {
  Future<List<Category>> getCategory() async {
    final response = await ApiService.create().getCategory();
    final List<Category> categories = response;
    return categories;
  }
}