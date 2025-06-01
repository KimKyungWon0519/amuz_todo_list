import 'package:amuz_todo_list/src/core/constants/app_constant.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TitleField extends ConsumerWidget {
  const TitleField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      maxLength: todoTitleMaxLength,
      decoration: InputDecoration(labelText: '제목'),
      onTapUpOutside: (_) => FocusScope.of(context).unfocus(),
      onSubmitted: (value) {
        ref.read(writeTodoNotifierProvider.notifier).setTitle(value);
        FocusScope.of(context).unfocus();
      },
    );
  }
}
