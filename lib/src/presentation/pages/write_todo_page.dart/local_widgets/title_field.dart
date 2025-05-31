import 'package:amuz_todo_list/src/presentation/riverpods/detail_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TitleField extends ConsumerWidget {
  const TitleField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(labelText: '제목'),
      onTapUpOutside: (_) => FocusScope.of(context).unfocus(),
      onSubmitted: (value) {
        ref.read(detailTodoNotifierProvider.notifier).setTitle(value);
        FocusScope.of(context).unfocus();
      },
    );
  }
}
