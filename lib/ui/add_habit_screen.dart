import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:habit_formation/component/add_new_habit_form.dart';

@RoutePage()
class AddHabitScreen extends StatelessWidget{
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Habit")),
      body: AddNewHabitForm()
    );
  }
}