import 'package:flutter/material.dart';
import 'package:habit_formation/app_router.dart';
import 'package:habit_formation/data/store/habit_formation_store.dart';
import 'package:habit_formation/injection/getit_setup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  getIt<HabitFormationStore>().createStore();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Habit Formation Tool",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
      ),
      routerConfig: _appRouter.config(),
    );
  }
}