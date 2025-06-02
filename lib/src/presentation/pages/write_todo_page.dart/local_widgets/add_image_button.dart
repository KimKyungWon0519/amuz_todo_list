import 'dart:io';

import 'package:amuz_todo_list/src/presentation/pages/add_image_panel/add_image_panel.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
          _addImage(context, ref);
        } else {
          ref.read(writeTodoNotifierProvider.notifier).selectImage(image!);
        }
      },
      child: Consumer(
        builder: (context, ref, child) {
          final Domain.Image? selectedImage = ref.watch(
            writeTodoNotifierProvider.select((value) => value.selectedImage),
          );

          bool isSelected = selectedImage != null && selectedImage == image;

          return Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey,
                width: 2,
              ),
              image:
                  !isPathEmpty
                      ? DecorationImage(image: FileImage(File(image!.url)))
                      : null,
            ),

            clipBehavior: Clip.hardEdge,
            child: isPathEmpty ? const _AddIcon() : null,
          );
        },
      ),
    );
  }

  void _addImage(BuildContext context, WidgetRef ref) async {
    String? path = await showAddImageBottomSheet(context);

    if (path != null) {
      Domain.Image domainImage = Domain.Image(url: path);

      ref.read(writeTodoNotifierProvider.notifier).addImage(domainImage);
    }
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
