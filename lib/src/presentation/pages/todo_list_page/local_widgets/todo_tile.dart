import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Text("Todo Name"),
          Spacer(),
          IconButton(onPressed: null, icon: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
