import 'package:habit_formation/data/entity/daily_status_entity.dart';
import 'package:habit_formation/data/entity/habit_entity.dart';
import 'package:habit_formation/data/store/habit_formation_store.dart';
import 'package:injectable/injectable.dart' hide Order;

import '../../objectbox.g.dart';

@injectable
class DailyStatusManager {
  HabitFormationStore habitFormationStore;
  late Box<DailyStatusEntity> dailyStatusBox;

  DailyStatusManager(this.habitFormationStore) {
    dailyStatusBox = habitFormationStore.store.box<DailyStatusEntity>();
  }

  Stream<List<DailyStatusEntity>> getStatusOf(HabitEntity habit){
    return dailyStatusBox
        .query(DailyStatusEntity_.habit.equals(habit.id))
        .order(DailyStatusEntity_.markingDate)
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  Future<void> markDoneForToday(HabitEntity habit) async {
    final today = DateTime.now();
    final dailyStatus = DailyStatusEntity(doneToday: true, markingDate: today);
    dailyStatus.habit.target = habit;
    dailyStatusBox.put(dailyStatus);
  }
}
