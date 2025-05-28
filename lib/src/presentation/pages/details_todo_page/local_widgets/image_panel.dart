import 'package:flutter/material.dart';

import 'image_pageview.dart';

class ImagePanel extends StatelessWidget {
  const ImagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 3,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ImagePageView(),
    );
  }
}
