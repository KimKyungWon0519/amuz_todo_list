import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/details_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoCheckbox extends ConsumerWidget {
  const TodoCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Todo todo = ref.watch(detailsTodoNotifierProvider);

    return Checkbox(
      value: todo.isDone,
      onChanged: (value) {
        if (value != null) {
          ref
              .read(detailsTodoNotifierProvider.notifier)
              .changeDoneState(todo, value);
        }
      },
    );
  }
}
