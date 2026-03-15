import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_formation/app_router.gr.dart';
import 'package:habit_formation/component/generic_error_widget.dart';
import 'package:habit_formation/data/category_list.dart';
import 'package:habit_formation/domain/model/habit_model.dart';
import 'package:habit_formation/injection/getit_setup.dart';
import 'package:habit_formation/ui/home_screen/events/home_screen_events.dart';
import 'package:habit_formation/ui/home_screen/home_screen_bloc.dart';
import 'package:habit_formation/ui/util/category_ui_model.dart';

import '../../../component/bold_text_widget.dart';
import '../../../component/bottom_sheet_circular_loader.dart';
import '../states/home_screen_states.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Habit Tracker")),
      body: BlocBuilder(
          bloc: getIt<HomeScreenBloc>()
            ..add(HomeScreenEvents.loadHabits()),
          builder: (BuildContext buildContext, HomeScreenStates state) {
            return state.when(loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            }, loaded: (habitStream) {
              return StreamBuilder(
                stream: habitStream,
                builder: (BuildContext streamBuildContext,
                    AsyncSnapshot<List<HabitModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return BottomSheetCircularLoader();
                  }
                  else if (snapshot.hasData) {
                    List<HabitModel> habits = snapshot.data?.toList() ??
                        List.empty();
                    return ListView.builder(
                        itemCount: habits.length,
                        itemBuilder: (BuildContext buildContext, int position) {
                          return habitTile(context, habits[position]);
                        });
                  }
                  else {
                    return SafeArea(
                      child: GenericErrorWidget(),
                    );
                  }
                },
              );
            }, error: (errorMessage) {
              return GenericErrorWidget();
            });
          }
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

  Card habitTile(BuildContext context, HabitModel habit) {
    final category = CategoryTypes.values.firstWhere((element) =>
    element.name == habit.category.name,
        orElse: () => CategoryTypes.runningWalkingCycling);
    var backgroundColor = CategoryUiModel.getColorScheme(category);
    return Card(
      color: backgroundColor,
      child: ListTile(
        title: BoldTextWidget(
          text: habit.category.name,
          textAlign: TextAlign.left,
          fontSize: 20,
          textColor: CategoryUiModel.getForegroundColorFor(backgroundColor),),
        leading: Icon(CategoryUiModel.getIcon(category), size: 50, color: CategoryUiModel.getForegroundColorFor(backgroundColor),),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Start Date: ${habit.formattedStartDate}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: CategoryUiModel.getForegroundColorFor(backgroundColor)),),
            Text("End Date: ${habit.formattedEndDate}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: CategoryUiModel.getForegroundColorFor(backgroundColor))),
          ],
        ),
        isThreeLine: false,
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          AutoRouter.of(context).navigate(HabitCompletionMarkerRoute(habitModel: habit));
        },
      ),
    );
  }
}
