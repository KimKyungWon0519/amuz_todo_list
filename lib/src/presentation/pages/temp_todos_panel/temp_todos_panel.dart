import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:flutter/material.dart';

import 'local_widgets/temp_todo_listview.dart';
import 'local_widgets/save_button.dart';

class TempTodosPanel extends StatelessWidget {
  final Todo todo;

  const TempTodosPanel({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [SaveButton(todo: todo)]),
      body: SafeArea(child: TempTodoListview()),
    );
  }
}

Future<int> showTempTodosPanel(BuildContext context, Todo todo) async {
  return await showModalBottomSheet(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.9,
    ),
    context: context,
    builder: (context) => TempTodosPanel(todo: todo),
    showDragHandle: true,
    isScrollControlled: true,
  ) ?? -1;
}
