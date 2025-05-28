import 'package:flutter/material.dart';

class ImageIndicator extends StatelessWidget {
  const ImageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text("1 / 5", style: TextStyle(color: Colors.white)),
    );
  }
}
