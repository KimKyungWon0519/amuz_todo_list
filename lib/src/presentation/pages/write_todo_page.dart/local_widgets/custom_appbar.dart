import 'package:flutter/material.dart';

import 'save_button.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("ToDo 추가"),
      actions: [
        TextButton(onPressed: null, child: Text('임시저장 | 0')),
        SaveButton(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
