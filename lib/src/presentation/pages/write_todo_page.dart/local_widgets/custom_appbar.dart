import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'save_button.dart';
import 'save_temp_button.dart';

class CustomAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final WriteTodoMode todo = ref.watch(
      writeTodoNotifierProvider.select((value) => value.mode),
    );

    return AppBar(
      title: Text("ToDo ${todo != WriteTodoMode.edit ? '작성' : '수정'}"),
      actions: [SaveTempButton(), SaveButton()],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
