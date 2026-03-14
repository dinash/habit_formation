import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_formation/data/repo/category_repo_impl.dart';

import 'events/category_selection_events.dart';
import 'states/category_selection_states.dart';

class CategorySelectionBloc
    extends Bloc<CategorySelectionEvent, CategorySelectionState> {
  CategoryRepoImpl repo;

  CategorySelectionBloc({required this.repo})
    : super(CategorySelectionLoading()) {
    on<CategorySelectionLoad>((event, emit) async {
      try {
        var list = await repo.getAllCategory();
        emit(CategorySelectionLoaded(categories: list));
      } catch (error) {
        emit(CategorySelectionError(message: error.toString()));
      }
    });
  }
}
