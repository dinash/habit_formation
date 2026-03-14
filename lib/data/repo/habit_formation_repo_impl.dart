import 'package:habit_formation/data/entity/category_entity.dart';
import 'package:habit_formation/data/entity/habit_entity.dart';
import 'package:habit_formation/data/store/category_manager.dart';
import 'package:habit_formation/data/store/habit_manager.dart';
import 'package:habit_formation/domain/habit_formation_repo.dart';
import 'package:habit_formation/domain/mapper/category_entity_to_model.dart';
import 'package:habit_formation/domain/model/category_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/habit_model.dart';

@Injectable(as: HabitFormationRepo)
class HabitFormationRepoImpl extends HabitFormationRepo {
  CategoryManager categoryManager;
  HabitManager habitManager;
  CategoryEntityToModel mapper;

  HabitFormationRepoImpl(
      {required this.categoryManager, required this.habitManager, required this.mapper});

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    List<CategoryEntity> list = await categoryManager.getAllCategory();
    return list.map((entity) => mapper.convert(entity)).toList();
  }

  @override
  Future<bool> addHabit(HabitModel habitModel) async {
    try {
      var category = await categoryManager.findCategoryById(
          habitModel.category.id);
      var habitEntity = HabitEntity(
          startDate: habitModel.startDate, endDate: habitModel.endDate);
      habitEntity.category.target = category;

      habitManager.addHabit(habitEntity);
      return true;
    }
    catch (error) {
      return false;
    }
  }

  @override
  Stream<List<HabitModel>> getAllHabits() {
    return habitManager.getAllHabit().map((list) =>
        list.map((entity) {
          var startDate = entity.startDate;
          var endDate = entity.endDate;
          CategoryModel categoryModel = CategoryModel(
              id: entity.category.targetId,
              name: entity.category.target?.name ?? ""
          );
          return HabitModel(
              category: categoryModel,
              startDate: startDate,
              endDate: endDate
          );
        }).toList());
  }


}
