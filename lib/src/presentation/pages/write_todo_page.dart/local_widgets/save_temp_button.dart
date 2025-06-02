import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/pages/temp_todos_panel/temp_todos_panel.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/local_database_notifier.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:amuz_todo_list/src/presentation/widgets/error_dialog.dart';
import 'package:amuz_todo_list/src/presentation/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SaveTempButton extends ConsumerWidget {
  const SaveTempButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Todo>> tempTodoIds = ref.watch(
      watchAllTempTodoIdsProvider,
    );

    int length = tempTodoIds.when(
      data: (data) => data.length,
      error: (_, __) => 0,
      loading: () => 0,
    );

    return TextButton(
      onPressed: () => _loadTempTodos(context, ref),
      child: Text('임시저장 | $length'),
    );
  }

  void _loadTempTodos(BuildContext context, WidgetRef ref) async {
    Todo todo = ref.read(
      writeTodoNotifierProvider.select((value) => value.todo),
    );

    int todoId = await showTempTodosPanel(context, todo);

    ref
        .read(writeTodoNotifierProvider.notifier).loadTempTodo(todoId);
  }
}
