import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'tag_chip.dart';
import 'tag_wrap.dart';

class SelectTag extends ConsumerWidget {
  const SelectTag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Set<Tag> tags = ref.watch(
      writeTodoNotifierProvider.select((value) => value.todo.tags),
    );

    return TagWrap(
      children:
          tags
              .map(
                (tag) => TagChip(
                  tag: tag,
                  onDeleted: () {
                    ref
                        .read(writeTodoNotifierProvider.notifier)
                        .unselectedTag(tag);
                  },
                ),
              )
              .toList(),
    );
  }
}
