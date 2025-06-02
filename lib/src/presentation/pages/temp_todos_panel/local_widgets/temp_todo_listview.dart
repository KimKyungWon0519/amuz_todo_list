import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/local_database_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'temp_todo_tile.dart';

class TempTodoListview extends ConsumerWidget {
  const TempTodoListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Todo>> tempTodoIds = ref.watch(
      watchAllTempTodoIdsProvider,
    );

    return tempTodoIds.when(
      data:
          (data) => ListView.builder(
            itemBuilder: (context, index) => TempTodoTile(todo: data[index]),
            itemCount: data.length,
          ),
      error: (_, __) => Container(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
