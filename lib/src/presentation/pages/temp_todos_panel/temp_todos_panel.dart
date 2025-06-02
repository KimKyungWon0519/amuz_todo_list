import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'local_widgets/temp_todo_listview.dart';

class TempTodosPanel extends StatelessWidget {
  const TempTodosPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: SafeArea(child: TempTodoListview()),
    );
  }
}

Future<Todo?> showTempTodosPanel(BuildContext context) async {
  return showModalBottomSheet(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.9,
    ),
    context: context,
    builder: (context) => TempTodosPanel(),
    showDragHandle: true,
    isScrollControlled: true,
  );
}
