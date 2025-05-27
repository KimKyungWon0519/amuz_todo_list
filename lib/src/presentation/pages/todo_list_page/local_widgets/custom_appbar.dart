import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("ToDo"),
      actions: [IconButton(onPressed: null, icon: Icon(Icons.search_rounded))],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
