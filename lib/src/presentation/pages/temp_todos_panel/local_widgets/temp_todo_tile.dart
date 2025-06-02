import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/local_database_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class TempTodoTile extends StatelessWidget {
  final Todo todo;

  const TempTodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('제목 : ${todo.title.isEmpty ? '비어있음' : todo.title}'),
      subtitle: Text('생성 날짜 : ${DateFormat.yMd('ko').format(todo.createAt)}'),
      onTap: () => context.pop(todo.id),
      trailing: Consumer(
        builder: (context, ref, child) {
          return IconButton(
            icon: const Icon(Icons.delete),
            onPressed:
                () async => ref.read(deleteTempTodoProvider(todo).future),
          );
        },
      ),
    );
  }
}
