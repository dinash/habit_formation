import 'package:habit_formation/domain/model/category_model.dart';

import 'model/habit_model.dart';

abstract class HabitFormationRepo {
  Future<List<CategoryModel>> getAllCategory();
  void addHabit(HabitModel habitModel);
  Stream<List<HabitModel>> getAllHabits();
}