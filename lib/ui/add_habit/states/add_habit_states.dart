import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_formation/domain/model/category_model.dart';

part 'add_habit_states.freezed.dart';

@freezed
abstract class AddHabitStates with _$AddHabitStates {
  AddHabitStates._();
  @override
  final today = DateTime.now();

  factory AddHabitStates({
    CategoryModel? category,
    required DateTime startDate,
    required DateTime endDate,
  }) =_AddHabitStates;

  factory AddHabitStates.initial() {
    final now = DateTime.now();

    return AddHabitStates(
      startDate: now,
      endDate: now.add(const Duration(days: 21)),
    );
  }
}
