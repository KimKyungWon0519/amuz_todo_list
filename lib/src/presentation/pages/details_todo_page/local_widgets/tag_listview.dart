import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/details_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TagListview extends ConsumerWidget {
  const TagListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Set<Tag> tags = ref.watch(
      detailsTodoNotifierProvider.select((value) => value.tags),
    );

    return ListView.builder(
      itemBuilder: (context, index) {
        Tag tag = tags.elementAt(index);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Chip(
            label: Text(tag.name),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            clipBehavior: Clip.hardEdge,
          ),
        );
      },
      itemCount: tags.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
