import 'package:get_it/get_it.dart';
import 'package:habit_formation/data/store/habit_formation_store.dart';

final getId = GetIt.instance;

void configureDependencies(){
  getId.registerLazySingleton(() => HabitFormationStore());
}