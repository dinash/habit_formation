import 'package:habit_formation/data/category_list.dart';
import 'package:habit_formation/data/entity/category_entity.dart';
import 'package:habit_formation/data/store/habit_formation_store.dart';
import 'package:habit_formation/objectbox.g.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryManager {
  HabitFormationStore habitFormationStore;
  late Box<CategoryEntity> categoryBox;

  CategoryManager(this.habitFormationStore) {
    categoryBox = habitFormationStore.store.box<CategoryEntity>();
  }

  Future<List<CategoryEntity>> getAllCategory() async {
    final all = categoryBox.getAll();
    if (all.isEmpty) {
      await insertDefaultCategory();
      return getAllCategory();
    }
    return Future.value(all);
  }

  Future<CategoryEntity> findCategoryById(int id) async {
    return categoryBox.get(id) ?? Future.error("Category not found");
  }

  Future<List<int>> insertDefaultCategory() async {
    List<CategoryEntity> list = CategoryTypes.values.map((e) => CategoryEntity(name: e.name)).toList(growable: false);
    return categoryBox.putMany(list);
    // return categoryBox.putMany([
    //   CategoryEntity(name: "Exercise / Workout"),
    //   CategoryEntity(name: "Running / Walking / Cycling"),
    //   CategoryEntity(name: "Stretching / Yoga"),
    //   CategoryEntity(name: "Drink water regularly"),
    //   CategoryEntity(name: "Eat fruits & vegetables"),
    //   CategoryEntity(name: "Sleep on time"),
    //   CategoryEntity(name: "Meditation / Mindfulness"),
    //   CategoryEntity(name: "Read a book"),
    //   CategoryEntity(name: "Listen to music"),
    // ]);
  }
}
