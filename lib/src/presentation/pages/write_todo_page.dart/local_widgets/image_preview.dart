import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) => SizedBox(
            height: constraints.maxWidth,
            width: constraints.maxWidth,
            child: Image.network(
              "https://storage.googleapis.com/cms-storage-bucket/22b6ce6f012cb7ee44bb.png",
            ),
          ),
    );
  }
}
