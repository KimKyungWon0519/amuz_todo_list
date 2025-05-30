import 'package:amuz_todo_list/src/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Todo Name"),
      trailing: Checkbox(value: false, onChanged: null),
      onTap: () => context.push(AppRoutes.detailsTodo.path),
    );
  }
}
