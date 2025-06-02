import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'save_button.dart';

class CustomAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Todo todo = ref.read(
      writeTodoNotifierProvider.select((value) => value.todo),
    );

    return AppBar(
      title: Text("ToDo ${todo.id != null ? "추가" : "수정"}"),
      actions: [
        TextButton(onPressed: null, child: Text('임시저장 | 0')),
        SaveButton(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
