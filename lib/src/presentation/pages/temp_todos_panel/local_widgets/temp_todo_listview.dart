import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/local_database_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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
            itemBuilder:
                (context, index) => ListTile(
                  title: Text(
                    '제목 : ${data[index].title.isEmpty ? '비어있음' : data[index].title}',
                  ),
                  subtitle: Text(
                    '생성 날짜 : ${DateFormat.yMd('ko').format(data[index].createAt)}',
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                  ),
                ),
            itemCount: data.length,
          ),
      error: (_, __) => Container(child: Text('??')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
