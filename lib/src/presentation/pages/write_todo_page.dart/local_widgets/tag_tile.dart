import 'package:flutter/material.dart';

class TagTile extends StatelessWidget {
  const TagTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(title: Text('태그'), trailing: Text('1개'), onTap: () {}),
    );
  }
}
