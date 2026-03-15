import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_formation/domain/model/habit_model.dart';
import 'package:habit_formation/domain/model/habit_tracking_status.dart';
import 'package:habit_formation/injection/getit_setup.dart';
import 'package:habit_formation/ui/habit_completion_marker/events/habit_completion_marker_events.dart';
import 'package:habit_formation/ui/habit_completion_marker/habit_completion_marker_bloc.dart';
import 'package:habit_formation/ui/habit_completion_marker/states/habit_completion_marker_states.dart';
import 'package:habit_formation/ui/habit_completion_marker/states/habit_completion_marker_ui_state.dart';

import '../../../component/bold_text_widget.dart';

@RoutePage()
class HabitCompletionMarkerScreen extends StatelessWidget {
  final HabitModel habitModel;

  const HabitCompletionMarkerScreen({required this.habitModel, super.key});

  @override
  Widget build(BuildContext context) {
    var habitCompletionMarkerBloc = getIt<HabitCompletionMarkerBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text("Habit Completion Marker")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder(
            bloc: habitCompletionMarkerBloc
              ..add(HabitCompletionMarkerEvents.loadDailyStatus(habitModel)),
            builder:
                (BuildContext buildContext, HabitCompletionMarkerStates state) {
                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: habitCompletionTile(
                          habitModel,
                          state.uiState,
                          habitCompletionMarkerBloc,
                        ),
                      ),
                      state.when(
                        loading: (_) =>
                            Center(child: CircularProgressIndicator()),
                        loaded: (_, _, data) {
                          return Expanded(
                            flex: 2,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton.icon(
                                  style: TextButton.styleFrom(
                                    side: BorderSide(color: Colors.blue, width: 2), // border
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // rounded corners
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  onPressed: null,
                                  label: Text(
                                    data[index].markingDate.toString(),
                                  ),
                                  icon: data[index].doneToday
                                      ? Icon(Icons.check_circle,color: Colors.green,)
                                      : Icon(
                                          Icons.remove_circle_outline, color: Colors.grey,
                                        ),
                                );
                              },
                            ),
                          );
                        },
                        error: (_, error) => Text(error),
                      ),
                    ],
                  );
                },
          ),
        ),
      ),
    );
  }

  Card habitCompletionTile(
    HabitModel habit,
    HabitCompletionMarkerUiState uiState,
    HabitCompletionMarkerBloc habitCompletionMarkerBloc,
  ) {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(8.0),
        width: double.infinity,
        child: Column(
          children: [
            Icon(Icons.home, size: 50),
            BoldTextWidget(
              text: habit.category.name,
              textAlign: TextAlign.left,
              fontSize: 20,
            ),
            Text(
              "Start Date: ${habit.formattedStartDate}",
              textAlign: TextAlign.left,
            ),
            Text(
              "End Date: ${habit.formattedEndDate}",
              textAlign: TextAlign.left,
            ),
            SizedBox.fromSize(size: Size(50, 50)),
            canMarkCompletion(uiState, habitCompletionMarkerBloc, habit),
          ],
        ),
      ),
    );
  }

  Widget canMarkCompletion(
    HabitCompletionMarkerUiState uiState,
    HabitCompletionMarkerBloc habitCompletionMarkerBloc,
    HabitModel habit,
  ) {
    switch (uiState.habitStatus) {
      case HabitTrackingStatus.notStarted:
        {
          return BoldTextWidget(
            text: "Can start marking completion once started",
          );
        }
      case HabitTrackingStatus.inProgress:
        {
          return FilledButton(
            onPressed: uiState.alreadyMarked
                ? null
                : () {
                    habitCompletionMarkerBloc.add(
                      HabitCompletionMarkerEvents.markDoneForToday(habit),
                    );
                  },
            child: Text("Mark done Today"),
          );
        }
      case HabitTrackingStatus.closed:
        {
          return BoldTextWidget(
            text: "Habit tracking is closed, can create new habit to track",
          );
        }
    }
  }
}
