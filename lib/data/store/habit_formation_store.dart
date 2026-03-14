import 'package:habit_formation/objectbox.g.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as pathjoiner;
import 'package:path_provider/path_provider.dart';

@lazySingleton
class HabitFormationStore {
  late Store store;

  Future<Store> createStore() async {
    var cacheDir = await getApplicationCacheDirectory();
    final file = pathjoiner.join(cacheDir.path, "habit_formation.db");
    store = await openStore(directory: file);
    return store;
  }
}
