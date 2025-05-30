import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'image_pageview.dart';
import 'image_indicator.dart';

class ImagePanel extends HookWidget {
  const ImagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = usePageController();

    return Container(
      height: MediaQuery.sizeOf(context).height / 3,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          ImagePageView(controller: pageController),
          Positioned(
            right: 0,
            child: ImageIndicator(controller: pageController),
          ),
        ],
      ),
    );
  }
}
