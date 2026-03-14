import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_formation/data/repo/habit_formation_repo_impl.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/category_model.dart';

part 'events/category_selection_events.dart';
part 'states/category_selection_states.dart';

@injectable
class CategorySelectionBloc
    extends Bloc<CategorySelectionEvent, CategorySelectionState> {
  HabitFormationRepoImpl repo;

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
