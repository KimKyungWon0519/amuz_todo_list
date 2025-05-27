import 'package:flutter/material.dart';

import 'local_widgets/todo_tile.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("ToDo")), body: TodoTile());
  }
}
