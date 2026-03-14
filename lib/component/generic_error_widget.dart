import 'package:flutter/material.dart';

class GenericErrorWidget extends StatelessWidget {
  const GenericErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                Text("Something went wrong!!!"),
                Text("Some please long message here to explain the error"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
