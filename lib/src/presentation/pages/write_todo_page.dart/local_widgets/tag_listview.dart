import 'package:amuz_todo_list/src/domain/model/tag.dart' show Tag;
import 'package:amuz_todo_list/src/presentation/riverpods/detail_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TagListview extends ConsumerWidget {
  const TagListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Tag> tags =
        ref
            .watch(detailTodoNotifierProvider.select((value) => value.tags))
            .toList();

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder:
          (context, index) => Chip(
            label: Text(tags[index].name),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
      itemCount: tags.length,
      separatorBuilder: (BuildContext context, int index) => SizedBox(width: 4),
    );
  }
}
