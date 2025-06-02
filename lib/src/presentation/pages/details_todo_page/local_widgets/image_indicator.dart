import 'package:amuz_todo_list/src/presentation/riverpods/details_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageIndicator extends HookConsumerWidget {
  final PageController? controller;

  const ImageIndicator({super.key, this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<int> currentIndex = useState(0);
    final int imageLength = ref.watch(
      detailsTodoNotifierProvider.select((value) => value.images.length),
    );

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
        "${imageLength != 0 ? currentIndex.value + 1 : 0} / $imageLength",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
