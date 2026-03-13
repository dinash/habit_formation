import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_formation/app_router.gr.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Habit Tracker")),
      body: Center(
        child: Text(
          "Here the list of habit that we wish to track will be shown.",
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            spacing: 16.0,
            children: [
              Expanded(
                child: FilledButton(onPressed: () {}, child: Text("Home")),
              ),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    AutoRouter.of(context).navigate(AddHabitRoute());
                  },
                  child: Text("Track New Habit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
