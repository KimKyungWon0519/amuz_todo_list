import 'package:flutter/material.dart';

import 'local_widgets/todo_title.dart';

class DetailsTodoPage extends StatelessWidget {
  const DetailsTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(16), child: TodoTitle()),
      ),
    );
  }
}
