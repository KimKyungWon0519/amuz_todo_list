import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("ToDo 추가"),
      actions: [
        TextButton(onPressed: null, child: Text('임시저장 | 0')),
        TextButton(onPressed: null, child: Text('저장')),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
