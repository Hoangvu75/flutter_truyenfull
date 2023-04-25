import 'package:bloc/bloc.dart';
import 'package:flutter_truyenfull/screens/homeScreen/repositories/CategoryRepository.dart';

import '../../repositories/UpdatedComicRepository.dart';
import 'CategoryEvent.dart';
import 'CategoryState.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  late final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryLoadingState()) {
    on<LoadCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        final categories = await _categoryRepository.getCategory();
        emit(CategoryLoadedState(categories));
      } on Exception catch (e) {
        emit(CategoryErrorState(e.toString()));
      }
    });
  }
}