import 'package:flutter/material.dart';

import 'image_pageview.dart';
import 'image_indicator.dart';

class ImagePanel extends StatelessWidget {
  const ImagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 3,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Positioned(right: 0, child: ImageIndicator()),
          ImagePageView(),
        ],
      ),
    );
  }
}
