import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:amuz_todo_list/src/domain/model/image.dart' as Domain;

class ImageDeleteButton extends ConsumerWidget {
  final Domain.Image? image;

  const ImageDeleteButton({super.key, required this.image});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(onPressed: () => _deleteImage(ref), child: Text('삭제'));
  }

  void _deleteImage(WidgetRef ref) {
    if (image != null) {
      ref.read(writeTodoNotifierProvider.notifier).deleteImage(image!);
    }
  }
}
