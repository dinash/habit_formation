import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_formation/app_router.gr.dart';
import 'package:habit_formation/component/bold_text_widget.dart';
import 'package:habit_formation/constants/asset_constants.dart';
import 'package:habit_formation/domain/habit_formation_repo.dart';
import 'package:habit_formation/injection/getit_setup.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final repo = getIt<HabitFormationRepo>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AssetConstants.kHabitSplash,
              repeat: true,
            ),
            BoldTextWidget(
              text: "Start building habits for better version of you !!!",
            ),
            FutureBuilder(
                future: repo.lastUpdatedDate(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (asyncSnapshot.hasData) {
                    return Text("last sync date : ${asyncSnapshot.data}");
                  }
                  else {
                    return Text("");
                  }
                }
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FilledButton(onPressed: () {
              router.navigate(HomeRoute());
            }, child: Text("Get Started")),
          )),
    );
  }
}
