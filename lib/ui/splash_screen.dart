import 'package:flutter/material.dart';
import 'package:habit_formation/component/bold_text_widget.dart';
import 'package:habit_formation/ui/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (buildContext) => HomeScreen()));
            }, child: Text("Get Started")),
          )),
    );
  }
}
