import 'package:amuz_todo_list/src/core/constants/app_constant.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TitleField extends HookConsumerWidget {
  const TitleField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = useTextEditingController();

    controller.text = ref.watch(writeTodoNotifierProvider).todo.title;

    return TextField(
      controller: controller,
      maxLength: todoTitleMaxLength,
      decoration: InputDecoration(labelText: '제목'),
      onTapUpOutside: (_) {
        ref.read(writeTodoNotifierProvider.notifier).setTitle(controller.text);
        FocusScope.of(context).unfocus();
      },
      onSubmitted: (value) {
        ref.read(writeTodoNotifierProvider.notifier).setTitle(value);
        FocusScope.of(context).unfocus();
      },
    );
  }
}
