import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_formation/component/bold_text_widget.dart';
import 'package:habit_formation/domain/model/category_model.dart';
import 'package:habit_formation/injection/getit_setup.dart';
import 'package:habit_formation/ui/add_habit/add_habit_bloc.dart';
import 'package:habit_formation/ui/add_habit/events/add_habit_events.dart';
import 'package:habit_formation/ui/add_habit/states/add_habit_states.dart';
import 'package:habit_formation/ui/category_selection/screen/category_selection_screen.dart';
import 'package:intl/intl.dart';

class AddNewHabitForm extends StatelessWidget {
  AddNewHabitForm({super.key});

  String formatDateTime(DateTime date) {
    return DateFormat(DateFormat.YEAR_MONTH_DAY).format(date);
  }

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var addHabitBloc = getIt<AddHabitBloc>();
    return BlocConsumer(
      bloc: addHabitBloc..add(AddHabitEvents.initial()),
      builder: (BuildContext buildContext, AddHabitStates state) {
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
                          onPressed: () async => await handleCategoryPicker(context, addHabitBloc),
                          child: BoldTextWidget(text: state.category?.name ??
                              "Select a category"),
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
                    onTap: () async => await startDatePickerHandling(state, context, addHabitBloc),
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
              )
          ),
          bottomNavigationBar: SafeArea(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FilledButton(
                onPressed: state.canSave ? () {
                  addHabitBloc.add(AddHabitEvents.saveHabit());
                  Navigator.pop(context);
                } : null, child: Text("Save Habit")),
          )),
        );
      },
      listener: (BuildContext buildContext, AddHabitStates state) {
        _startDateController.text = formatDateTime(state.startDate);
        _endDateController.text = formatDateTime(state.endDate);
      },
    );
  }

  Future<void> startDatePickerHandling(AddHabitStates state, BuildContext context, AddHabitBloc addHabitBloc) async {
    final DateTime? newlySelectedStartDate = await showDatePicker(
      initialDate: state.startDate,
      firstDate: state.today,
      lastDate: DateTime.now().add(Duration(days: 365)),
      context: context,
    );
    if (newlySelectedStartDate != null) {
      addHabitBloc.add(AddHabitEvents.onStartDateSelected(
          newlySelectedStartDate));

      _focusNode.unfocus();
    }
  }

  Future<void> handleCategoryPicker(BuildContext context, AddHabitBloc addHabitBloc) async {
    final selectedCategory =
    await showModalBottomSheet<CategoryModel>(
      context: context,
      builder: (buildContext) =>
          CategorySelectionScreen(),
    );

    if (selectedCategory != null) {
      addHabitBloc.add(
          AddHabitEvents.onCategorySelected(
              selectedCategory));
    }
  }
}
