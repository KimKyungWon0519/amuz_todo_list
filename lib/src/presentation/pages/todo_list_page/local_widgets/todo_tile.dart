import 'package:amuz_todo_list/src/core/routes/app_routes.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/todo_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Consumer(
        builder: (context, ref, child) {
          return Checkbox(
            value: todo.isDone,
            onChanged: (value) {
              if (value != null) {
                ref
                    .read(todoListNotifierProvider.notifier)
                    .changeDoneState(todo, value);
              }
            },
          );
        },
      ),
      onTap: () => context.push(AppRoutes.detailsTodo.path, extra: todo),
    );
  }
}
