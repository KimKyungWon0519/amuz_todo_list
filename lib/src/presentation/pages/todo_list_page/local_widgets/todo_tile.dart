import 'package:amuz_todo_list/src/core/routes/app_routes.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(value: todo.isDone, onChanged: null),
      onTap: () => context.push(AppRoutes.detailsTodo.path),
    );
  }
}
