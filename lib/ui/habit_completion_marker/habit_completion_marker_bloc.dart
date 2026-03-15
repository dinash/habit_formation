import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_formation/domain/habit_formation_repo.dart';
import 'package:habit_formation/domain/model/habit_tracking_status.dart';
import 'package:habit_formation/ui/habit_completion_marker/events/habit_completion_marker_events.dart';
import 'package:habit_formation/ui/habit_completion_marker/states/habit_completion_marker_states.dart';
import 'package:habit_formation/ui/habit_completion_marker/states/habit_completion_marker_ui_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class HabitCompletionMarkerBloc
    extends Bloc<HabitCompletionMarkerEvents, HabitCompletionMarkerStates> {
  final HabitFormationRepo habitFormationRepo;

  HabitCompletionMarkerBloc({required this.habitFormationRepo})
    : super(
        HabitCompletionMarkerStates.loading(
          HabitCompletionMarkerUiState.initial(),
        ),
      ) {
    on<HabitCompletionMarkerEvents>((event, emit) async {
      await event.map(
        loadDailyStatus: (event) async {
          try {
            final dailyStatus = await habitFormationRepo.getAllStatusOf(
              event.habitModel,
            );
            final today = DateTime.now();
            if ((today.isAfter(event.habitModel.startDate) || _isSameDay(today, event.habitModel.startDate))&&
                (today.isBefore(event.habitModel.endDate) || _isSameDay(today, event.habitModel.endDate))) {
              var markedAlready = dailyStatus.lastWhere(
                (element) => _isSameDay(element.markingDate, DateTime.now()),
              );
              var habitCompletionMarkerStates =
                  HabitCompletionMarkerStates.loaded(
                    state.uiState.copyWith(
                      alreadyMarked: markedAlready.doneToday,
                      habitStatus: HabitTrackingStatus.inProgress,
                    ),
                    event.habitModel,
                    dailyStatus,
                  );
              emit(habitCompletionMarkerStates);
            } else if (today.isBefore(event.habitModel.startDate)) {
              var habitCompletionMarkerStates =
                  HabitCompletionMarkerStates.loaded(
                    state.uiState.copyWith(habitStatus: HabitTrackingStatus.notStarted),
                    event.habitModel,
                    dailyStatus,
                  );
              emit(habitCompletionMarkerStates);
            } else if (today.isAfter(event.habitModel.endDate)) {
              var habitCompletionMarkerStates =
                  HabitCompletionMarkerStates.loaded(
                    state.uiState.copyWith(habitStatus: HabitTrackingStatus.closed),
                    event.habitModel,
                    dailyStatus,
                  );
              emit(habitCompletionMarkerStates);
            }
          } catch (error) {
            emit(
              HabitCompletionMarkerStates.error(
                state.uiState,
                error.toString(),
              ),
            );
          }
        },
        markDoneForToday: (event) {
          habitFormationRepo.markDoneForToday(event.habitModel);
          add(HabitCompletionMarkerEvents.loadDailyStatus(event.habitModel));
        },
      );
    });
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
