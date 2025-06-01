import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => _onPressed(context, ref),
      child: Text('저장'),
    );
  }

  void _onPressed(BuildContext context, WidgetRef ref) {
    Todo todo = ref.read(writeTodoNotifierProvider).todo;

    if (todo.title.trim().isEmpty) {
      showErrorDialog(context, title: '저장 실패', content: '제목을 입력해주세요.');

      return;
    }
  }
}
