import 'package:amuz_todo_list/src/presentation/pages/todo_list_page/local_widgets/todo_tile.dart';
import 'package:flutter/material.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder:
          (context, index) => Dismissible(key: UniqueKey(), child: TodoTile()),
      itemCount: 50,
    );
  }
}
