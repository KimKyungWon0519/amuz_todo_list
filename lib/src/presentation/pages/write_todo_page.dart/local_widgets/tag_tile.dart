import 'package:amuz_todo_list/src/presentation/riverpods/detail_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TagTile extends StatelessWidget {
  const TagTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('태그'),
        trailing: Consumer(
          builder: (context, ref, child) {
            final int tagCount = ref.watch(
              detailTodoNotifierProvider.select((value) => value.tags.length),
            );

            return Text('$tagCount 개');
          },
        ),
        onTap: () {},
      ),
    );
  }
}
