import 'package:habit_formation/data/store/habit_formation_store.dart';
import 'package:habit_formation/domain/model/sort_type.dart';
import 'package:injectable/injectable.dart' hide Order;

import '../../objectbox.g.dart';
import '../entity/habit_entity.dart';

@injectable
class HabitManager {
  late Box<HabitEntity> _habitBox;

  HabitManager({required HabitFormationStore habitFormationStore}) {
    _habitBox = habitFormationStore.store.box<HabitEntity>();
  }

  Future<int> addHabit(HabitEntity habitEntity) async {
    return _habitBox.put(habitEntity);
  }

  Stream<List<HabitEntity>> getAllHabit({SortType? sortType}) {
    var field = HabitEntity_.id;
    var order = 0;
    final finalSortType = sortType ?? SortType.defaultSort();
    field = switch(finalSortType.sortField){
      SortField.byAddedDate => HabitEntity_.id,
      SortField.byStartDate => HabitEntity_.startDate,
      SortField.byEndDate => HabitEntity_.endDate,
      SortField.byCategory => HabitEntity_.category
    };

    if (finalSortType.sortOrder case SortOrder.descending) {
      order = Order.descending;
    }
    if(field == HabitEntity_.category){
      return sortByCategory(order);
    }

    return _habitBox
        .query()
        .order(field, flags: order)
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  Stream<List<HabitEntity>> sortByCategory(int order) {
    return _habitBox
        .query()
        .watch(triggerImmediately: true)
        .map((query) {
      return query.find()
        ..sort((firstElement, secondElement) {
          if (order == Order.descending) {
            return sortBy(secondElement, firstElement);
          } else {
            return sortBy(firstElement, secondElement);
          }
        });
        });
  }

  int sortBy(HabitEntity b, HabitEntity a) {
    return (b.category.target?.name ?? "").compareTo(
        a.category.target?.name ?? "");
  }

  Stream<List<HabitEntity>> getAllHabitSortedByDate(){
    return _habitBox
        .query()
        .order(HabitEntity_.startDate, flags: Order.descending)
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  Future<HabitEntity> findHabitById(int id) async {
    return _habitBox.get(id) ?? Future.error("Habit not found");
  }
}
