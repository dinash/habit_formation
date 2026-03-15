import 'package:habit_formation/data/entity/category_entity.dart';
import 'package:habit_formation/data/entity/daily_status_entity.dart';
import 'package:habit_formation/data/entity/habit_entity.dart';
import 'package:habit_formation/data/store/category_manager.dart';
import 'package:habit_formation/data/store/daily_status_manager.dart';
import 'package:habit_formation/data/store/habit_manager.dart';
import 'package:habit_formation/domain/habit_formation_repo.dart';
import 'package:habit_formation/domain/mapper/category_entity_to_model.dart';
import 'package:habit_formation/domain/model/category_model.dart';
import 'package:habit_formation/domain/model/daily_status_model.dart';
import 'package:habit_formation/domain/model/sort_type.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/habit_model.dart';

@Injectable(as: HabitFormationRepo)
class HabitFormationRepoImpl extends HabitFormationRepo {
  CategoryManager categoryManager;
  HabitManager habitManager;
  DailyStatusManager dailyStatusManager;
  CategoryEntityToModel mapper;

  HabitFormationRepoImpl(
      {required this.categoryManager, required this.habitManager, required this.dailyStatusManager, required this.mapper});

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
  Stream<List<HabitModel>> getAllHabits(SortType sortType) {
    return habitManager.getAllHabit(sortType: sortType).map((list) =>
        list.map((entity) {
          var startDate = entity.startDate;
          var endDate = entity.endDate;
          CategoryModel categoryModel = CategoryModel(
              id: entity.category.targetId,
              name: entity.category.target?.name ?? ""
          );
          return HabitModel(
              id: entity.id,
              category: categoryModel,
              startDate: startDate,
              endDate: endDate
          );
        }).toList());
  }

  @override
  Future<List<DailyStatusModel>> getAllStatusOf(HabitModel habitModel) async {
    try {
      final habitEntity = await habitManager.findHabitById(habitModel.id);
      List<DailyStatusModel> result = [];
      List<DailyStatusEntity> list = await dailyStatusManager.getStatusOf(habitEntity).first;

      for (DateTime d = habitEntity.startDate;
      !d.isAfter(habitEntity.endDate);
      d = d.add(const Duration(days: 1))) {
        final completed = list.any(
              (dailyStatusEntity) => _isSameDay(dailyStatusEntity.markingDate, d),
        );

        result.add(DailyStatusModel(doneToday: completed, markingDate: d));
      }

      return result;
    }
    catch(error){
      return Future.error(error);
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  @override
  void markDoneForToday(HabitModel habitModel) async{
    final habitEntity = await habitManager.findHabitById(habitModel.id);
    dailyStatusManager.markDoneForToday(habitEntity);
  }


}
