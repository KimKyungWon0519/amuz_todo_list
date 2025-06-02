import 'dart:io';

import 'package:amuz_todo_list/src/presentation/riverpods/details_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:amuz_todo_list/src/domain/model/image.dart' as Domain;

class ImagePageView extends ConsumerWidget {
  final PageController? controller;

  const ImagePageView({super.key, this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Domain.Image> images = ref.watch(
      detailsTodoNotifierProvider.select((value) => value.images),
    );

    return PageView.builder(
      controller: controller,
      itemBuilder:
          (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Image.file(File(images[index].url)),
          ),
      itemCount: images.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
