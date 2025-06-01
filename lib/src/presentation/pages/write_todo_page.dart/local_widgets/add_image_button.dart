import 'dart:io';

import 'package:amuz_todo_list/src/presentation/riverpods/detail_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amuz_todo_list/src/domain/model/image.dart' as Domain;

class AddImageButton extends ConsumerWidget {
  final Domain.Image? image;
  final Size size;

  const AddImageButton({super.key, this.image, required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (isPathEmpty) {
          _addImage(context);
        } else {
          ref.read(detailTodoNotifierProvider.notifier).selectImage(image!);
        }
      },
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 2),
          image:
              !isPathEmpty
                  ? DecorationImage(image: FileImage(File(image!.url)))
                  : null,
        ),

        clipBehavior: Clip.hardEdge,
        child: isPathEmpty ? const _AddIcon() : null,
      ),
    );
  }

  void _addImage(BuildContext context) async {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => const _AddImageBottomSheet(),
    );
  }

  bool get isPathEmpty => image == null || image!.url.isEmpty;
}

class _AddIcon extends StatelessWidget {
  const _AddIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Icon(Icons.add_a_photo, color: Colors.grey, size: 30));
  }
}

class _AddImageBottomSheet extends ConsumerWidget {
  const _AddImageBottomSheet({super.key});

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

    if (image != null) {
      Domain.Image domainImage = Domain.Image(url: image.path);

      ref.read(detailTodoNotifierProvider.notifier).addImage(domainImage);

      context.pop();
    }
  }
}
