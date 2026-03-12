import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_formation/app_router.gr.dart';
import 'package:habit_formation/component/bold_text_widget.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: BoldTextWidget(
            text: "Start building habits for better version of you !!!",
          ),
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
