import 'package:flutter/material.dart';

import 'local_widgets/todo_listview.dart';
import 'local_widgets/custom_appbar.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppbar(), body: TodoListView());
  }
}
