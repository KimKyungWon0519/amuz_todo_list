import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/widgets/error_dialog.dart';
import 'package:amuz_todo_list/src/presentation/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  void _onPressed(BuildContext context, WidgetRef ref) async {
    WriteTodoState state = ref.read(writeTodoNotifierProvider);
    Todo todo = state.todo;
    WriteTodoMode mode = state.mode;

    if (todo.title.trim().isEmpty) {
      showErrorDialog(context, title: '저장 실패', content: '제목을 입력해주세요.');

      return;
    }

    showLoadingDialog(context);

    bool result = false;

    switch (mode) {
      case WriteTodoMode.create:
        result = await ref
            .read(writeTodoNotifierProvider.notifier)
            .createTodo()
            .then((value) {
              context.pop();

              return value;
            });

        break;
      case WriteTodoMode.edit:
        todo = todo.copyWith(updateAt: DateTime.now());

        result = await ref
            .read(writeTodoNotifierProvider.notifier)
            .editTodo(todo)
            .then((value) {
              context.pop();

              return value;
            });

        break;
      case WriteTodoMode.loadTemp:
        todo = todo.copyWith(createAt: DateTime.now());

        result = await ref
            .read(writeTodoNotifierProvider.notifier)
            .saveTodoAndRemoveTempTodo(todo)
            .then((value) {
              context.pop();

              return value;
            });

        break;
    }

    if (result) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('저장 완료'),
              actions: [
                TextButton(onPressed: () => context.pop(), child: Text('확인')),
              ],
            ),
      ).then((value) {
        context.pop(todo);
      });
    } else {
      showErrorDialog(
        context,
        title: '저장 실패',
        content: '저장에 실패했습니다. 다시 시도해주세요.',
      );
    }
  }
}
