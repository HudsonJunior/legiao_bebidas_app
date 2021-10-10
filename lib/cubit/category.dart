import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:legiao_bebidas_app/models/category.dart';

class CategoryState {
  final CategoryEnum currentCategory;

  CategoryState({
    this.currentCategory = CategoryEnum.todos,
  });

  CategoryState copyWith({CategoryEnum? category}) => CategoryState(
        currentCategory: category ?? this.currentCategory,
      );
}

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryState());

  void updateCurrentCategory(CategoryEnum newCategory) {
    emit(state.copyWith(category: newCategory));
  }
}
