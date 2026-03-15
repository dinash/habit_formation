import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_formation/domain/habit_formation_repo.dart';
import 'package:habit_formation/domain/model/habit_model.dart';
import 'package:injectable/injectable.dart';

import 'events/add_habit_events.dart';
import 'states/add_habit_states.dart';

@injectable
class AddHabitBloc extends Bloc<AddHabitEvents, AddHabitStates> {
  HabitFormationRepo repo;

  AddHabitBloc({required this.repo}) : super(AddHabitStates.initial()) {
    on<AddHabitEvents>((event, emit) async {
      event.map(
        initial: (initial) => emit(AddHabitStates.initial()),
        onCategorySelected: (onCategorySelected) =>
            emit(state.copyWith(category: onCategorySelected.selectedCategory, canSave: true)),
        onStartDateSelected: (onStartDateSelected) => emit(
          state.copyWith(
            startDate: onStartDateSelected.selectedStartDate,
            endDate: onStartDateSelected.selectedStartDate.add(
              Duration(days: 21),
            ),
          ),
        ),
        saveHabit: (onSaveHabit) {
          HabitModel model = HabitModel(
            category: state.category!,
            startDate: state.startDate,
            endDate: state.endDate,
          );
          repo.addHabit(model);
        },
      );
    });
  }
}
