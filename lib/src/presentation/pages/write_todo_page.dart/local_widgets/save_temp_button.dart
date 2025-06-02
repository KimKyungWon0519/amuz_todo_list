import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:amuz_todo_list/src/presentation/widgets/error_dialog.dart';
import 'package:amuz_todo_list/src/presentation/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SaveTempButton extends ConsumerWidget {
  const SaveTempButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => _saveTemp(context, ref),
      child: Text('임시저장 | 0'),
    );
  }

  void _saveTemp(BuildContext context, WidgetRef ref) async {
    showLoadingDialog(context);

    bool result = await ref
        .read(writeTodoNotifierProvider.notifier)
        .saveTempTodo()
        .then((value) {
          context.pop();

          return value;
        });

    if (result) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('임시저장 완료'),
              content: Text('임시저장이 완료되었습니다.'),
              actions: [
                TextButton(onPressed: () => context.pop(), child: Text('확인')),
              ],
            ),
      );
    } else {
      showErrorDialog(
        context,
        title: '임시저장 실패',
        content: '임시 저장에 실패했습니다. 다시 시도해주세요.',
      );
    }
  }
}
