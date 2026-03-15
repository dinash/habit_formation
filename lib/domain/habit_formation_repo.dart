import 'package:habit_formation/domain/model/category_model.dart';
import 'package:habit_formation/domain/model/daily_status_model.dart';

import 'model/habit_model.dart';

abstract class HabitFormationRepo {
  Future<List<CategoryModel>> getAllCategory();
  void addHabit(HabitModel habitModel);
  Stream<List<HabitModel>> getAllHabits();

  void markDoneForToday(HabitModel habitModel);
  Future<List<DailyStatusModel>> getAllStatusOf(HabitModel habitModel);
}