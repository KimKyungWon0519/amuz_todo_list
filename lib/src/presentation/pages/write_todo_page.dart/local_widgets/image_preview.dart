import 'dart:io';

import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:amuz_todo_list/src/domain/model/image.dart' as Domain;

class ImagePreview extends ConsumerWidget {
  const ImagePreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Domain.Image? selectedImage = ref.watch(
      writeTodoNotifierProvider.select((value) => value.selectedImage),
    );

    return LayoutBuilder(
      builder:
          (context, constraints) => SizedBox(
            height: constraints.maxWidth,
            width: constraints.maxWidth,
            child:
                selectedImage != null
                    ? Image.file(File(selectedImage.url))
                    : const Center(child: Text('이미지를 선택해주세요')),
          ),
    );
  }
}
