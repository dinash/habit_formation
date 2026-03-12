import 'package:flutter/material.dart';

class BoldTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;

  const BoldTextWidget({super.key, required this.text, this.fontSize = 25});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}
