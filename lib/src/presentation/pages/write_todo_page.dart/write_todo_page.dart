import 'package:flutter/material.dart';

import 'local_widgets/title_field.dart';

class WriteTodoPage extends StatelessWidget {
  const WriteTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ToDo 추가")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 8, children: [TitleField()]),
      ),
    );
  }
}
