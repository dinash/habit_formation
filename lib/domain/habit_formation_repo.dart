import 'package:habit_formation/domain/model/category_model.dart';

abstract class HabitFormationRepo {
  Future<List<CategoryModel>> getAllCategory();
}