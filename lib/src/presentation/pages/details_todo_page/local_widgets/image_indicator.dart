import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImageIndicator extends HookWidget {
  final PageController? controller;

  const ImageIndicator({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndex = useState(0);

    useEffect(() {
      void updateCurrentIndex() {
        if (controller!.page != null &&
            controller!.page! != currentIndex.value) {
          currentIndex.value = controller!.page!.toInt();
        }
      }

      controller?.addListener(updateCurrentIndex);

      return () => controller?.removeListener(updateCurrentIndex);
    }, []);

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        "${currentIndex.value + 1} / 5",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
