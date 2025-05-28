import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        PopupMenuButton(
          itemBuilder:
              (context) => [
                PopupMenuItem(child: Text("수정")),
                PopupMenuItem(child: Text("삭제")),
              ],
          icon: Icon(Icons.more_horiz),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
