import 'package:amuz_todo_list/src/presentation/riverpods/detail_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:amuz_todo_list/src/domain/model/image.dart' as Domain;

import 'add_image_button.dart';

class AddImageButtonsRow extends ConsumerWidget {
  const AddImageButtonsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Domain.Image> images = ref.watch(
      detailTodoNotifierProvider.select((value) => value.images),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        double itemSize = constraints.maxWidth / 5.5;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: List.generate(
            images.length + images.length < 5 ? 1 : 0,
            (_) => AddImageButton(size: Size(itemSize, itemSize)),
          ),
        );
      },
    );
  }
}
