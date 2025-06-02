import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class DueDate extends ConsumerWidget {
  const DueDate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime dueDate = ref.watch(
      writeTodoNotifierProvider.select((value) => value.todo.dueDate),
    );

    return TextButton(
      child: Text('마감일 : ${DateFormat.yMd('ko').format(dueDate)}'),
      onPressed: () {
        showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2300),
          initialDate: dueDate,
        ).then((value) {
          if (value != null) {
            ref.read(writeTodoNotifierProvider.notifier).setDueDate(value);
          }
        });
      },
    );
  }
}
