import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_formation/domain/habit_formation_repo.dart';
import 'package:habit_formation/ui/home_screen/events/home_screen_events.dart';
import 'package:habit_formation/ui/home_screen/states/home_screen_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeScreenBloc extends Bloc<HomeScreenEvents, HomeScreenStates> {
  HabitFormationRepo repo;

  HomeScreenBloc({required this.repo}) : super(HomeScreenStates.loading()) {
    on<HomeScreenEvents>((event, emit) async {
      await event.map(loadHabits: (loadHabits) async => _getAllHabits(event, emit));
    });
  }

  void _getAllHabits(HomeScreenEvents events, Emitter<HomeScreenStates> emit) {
    try {
      final habits = repo.getAllHabits(events.sortType);
      emit(HomeScreenStates.loaded(habits));
    } catch (error) {
      emit(HomeScreenStates.error(error.toString()));
    }
  }
}
