import 'package:habit_formation/data/store/habit_formation_store.dart';
import 'package:injectable/injectable.dart';

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

  Stream<List<HabitEntity>> getAllHabit() {
    return _habitBox
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  Stream<List<HabitEntity>> getAllHabitSortedByDate(){
    return _habitBox
        .query()
        .order(HabitEntity_.startDate)
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }
}
