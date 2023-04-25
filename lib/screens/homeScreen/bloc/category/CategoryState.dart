import 'package:flutter_truyenfull/apiResponse/Category.dart';

abstract class CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  CategoryLoadedState(this.categories);
  final List<Category> categories;
}

class CategoryErrorState extends CategoryState {
  CategoryErrorState(this.error);
  final String error;
}