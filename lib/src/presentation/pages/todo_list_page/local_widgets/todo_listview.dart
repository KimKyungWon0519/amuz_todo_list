import 'package:amuz_todo_list/src/presentation/pages/todo_list_page/local_widgets/todo_tile.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/todo_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue todos = ref.watch(todoListNotifierProvider);

    return todos.when(
      data: (todos) {
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return TodoTile(todo: todos[index]);
          },
        );
      },
      error: (_, __) => Center(child: Text('오류가 발생하여 목록을 불러올 수 없습니다.')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
