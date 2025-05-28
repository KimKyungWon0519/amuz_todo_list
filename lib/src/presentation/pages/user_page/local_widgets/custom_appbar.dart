import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return  AppBar(title: Text('프로필'));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
