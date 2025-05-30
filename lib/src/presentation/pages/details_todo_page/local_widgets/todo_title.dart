import 'package:flutter/material.dart';

class TodoTitle extends StatelessWidget {
  const TodoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Todo Name', style: Theme.of(context).textTheme.headlineMedium);
  }
}
