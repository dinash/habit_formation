import 'package:habit_formation/objectbox.g.dart';
import 'package:path/path.dart' as pathjoiner;
import 'package:path_provider/path_provider.dart';


class HabitFormationStore {
  Future<Store> createStore() async {
    var cacheDir = await getApplicationCacheDirectory();
    final file = pathjoiner.join(cacheDir.path, "habit_formation.db");
    return openStore(directory: file);
  }
}
