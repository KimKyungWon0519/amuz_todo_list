import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddImageBottomSheet extends ConsumerWidget {
  const AddImageBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('사진 촬영'),
            onTap: () => _addImage(context, ref, ImageSource.camera),
          ),
          ListTile(
            title: Text('사진 가져오기'),
            onTap: () => _addImage(context, ref, ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  void _addImage(
    BuildContext context,
    WidgetRef ref,
    ImageSource imageSource,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: imageSource);

    context.pop(image?.path);
  }
}

Future<String?> showAddImageBottomSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    showDragHandle: true,
    context: context,
    builder: (context) => const AddImageBottomSheet(),
  );
}
