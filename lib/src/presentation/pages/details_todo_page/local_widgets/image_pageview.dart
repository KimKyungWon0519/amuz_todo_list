import 'package:flutter/material.dart';

class ImagePageView extends StatelessWidget {
  const ImagePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder:
          (context, index) => Image.network(
            "https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png",
          ),
      itemCount: 5,
      scrollDirection: Axis.horizontal,
    );
  }
}
