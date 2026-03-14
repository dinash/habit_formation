import 'package:flutter/material.dart';

class BottomSheetCircularLoader extends StatelessWidget {
  const BottomSheetCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
  }
}
