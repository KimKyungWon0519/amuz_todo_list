import 'package:flutter/material.dart';

class ImagePageView extends StatelessWidget {
  final PageController? controller;

  const ImagePageView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemBuilder:
          (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Image.network(
              "https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png",
            ),
          ),
      itemCount: 5,
      scrollDirection: Axis.horizontal,
    );
  }
}
