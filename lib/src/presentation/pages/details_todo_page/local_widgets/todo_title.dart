import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/details_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoTitle extends ConsumerWidget {
  const TodoTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Todo todo = ref.watch(detailsTodoNotifierProvider);

    return Text(
      todo.title,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        decoration: todo.isDone ? TextDecoration.lineThrough : null,
      ),
    );
  }
}
