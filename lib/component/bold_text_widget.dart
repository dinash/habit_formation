import 'package:flutter/material.dart';

class BoldTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final Color textColor;

  const BoldTextWidget(
      {super.key, required this.text, this.fontSize = 25, this.textAlign = TextAlign
          .center, this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor),
      textAlign: textAlign,
    );
  }
}
