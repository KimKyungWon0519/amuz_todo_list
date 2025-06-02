import 'package:amuz_todo_list/src/presentation/riverpods/details_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoTitle extends ConsumerWidget {
  const TodoTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = ref.watch(
      detailsTodoNotifierProvider.select((value) => value.title),
    );

    print(title);

    return Text(title, style: Theme.of(context).textTheme.headlineMedium);
  }
}
