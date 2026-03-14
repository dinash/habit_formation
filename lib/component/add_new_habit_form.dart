import 'package:flutter/material.dart';
import 'package:habit_formation/domain/habit_formation_repo.dart';
import 'package:habit_formation/domain/model/category_model.dart';
import 'package:habit_formation/domain/model/habit_model.dart';
import 'package:habit_formation/injection/getit_setup.dart';
import 'package:habit_formation/ui/category_selection_screen.dart';
import 'package:intl/intl.dart';

class AddNewHabitForm extends StatefulWidget {
  const AddNewHabitForm({super.key});

  @override
  State<AddNewHabitForm> createState() => _AddNewHabitFormState();
}

class _AddNewHabitFormState extends State<AddNewHabitForm> {
  var _currentStartDate = DateTime.now();

  DateTime get _currentEndDate => _currentStartDate.add(Duration(days: 21));
  CategoryModel? _currentCategory;

  String get _currentStartDateAsString => formatDateTime(_currentStartDate);

  String get _currentEndDateAsString => formatDateTime(_currentEndDate);

  String formatDateTime(DateTime date) {
    return DateFormat(DateFormat.YEAR_MONTH_DAY).format(date);
  }

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _startDateController.text = _currentStartDateAsString;
    _endDateController.text = _currentEndDateAsString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final selectedCategory =
                          await showModalBottomSheet<CategoryModel>(
                            context: context,
                            builder: (buildContext) =>
                                CategorySelectionScreen(),
                          );
                      if (_currentCategory != null &&
                          selectedCategory == null) {
                        return;
                      }
                      _currentCategory = selectedCategory;
                      setState(() {});
                    },
                    child: Text(_currentCategory?.name ?? "Select a Category"),
                  ),
                ),
              ],
            ),
            TextField(
              focusNode: _focusNode,
              decoration: InputDecoration(
                label: Text("Start Date"),
                border: OutlineInputBorder(),
              ),
              controller: _startDateController,
              readOnly: true,
              onTap: () async {
                final DateTime? newlySelectedStartDate = await showDatePicker(
                  initialDate: _currentStartDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  context: context,
                );
                if (newlySelectedStartDate != null) {
                  _currentStartDate = newlySelectedStartDate;
                  _startDateController.text = _currentStartDateAsString;
                  _endDateController.text = _currentEndDateAsString;
                  setState(() {});
                  _focusNode.unfocus();
                }
              },
            ),
            TextField(
              decoration: InputDecoration(
                label: Text("End Date"),
                border: OutlineInputBorder(),
              ),
              controller: _endDateController,
              readOnly: true,
              enabled: false,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea( child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FilledButton(
            onPressed: () {
              if (_currentCategory != null) {
                final habitModel = HabitModel(category: _currentCategory!,
                    startDate: _currentStartDate,
                    endDate: _currentEndDate);
                getIt<HabitFormationRepo>().addHabit(habitModel);
                Navigator.pop(context);
              }
            }, child: Text("Save Habit")),
      )),
    );
  }
}
