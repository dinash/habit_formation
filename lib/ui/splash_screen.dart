import 'package:flutter/material.dart';
import 'package:habit_formation/component/bold_text_widget.dart';

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
    );
  }
}
