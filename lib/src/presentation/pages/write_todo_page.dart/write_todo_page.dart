import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/write_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'local_widgets/image_preview.dart';
import 'local_widgets/title_field.dart';
import 'local_widgets/add_image_buttons_row.dart';
import 'local_widgets/custom_appbar.dart';
import 'local_widgets/tag_tile.dart';

class WriteTodoPage extends StatelessWidget {
  final Todo? todo;

  const WriteTodoPage({super.key, this.todo});

  @override
  Widget build(BuildContext context) {
    if (todo != null) {
      Future.delayed(Duration.zero, () {
        ProviderContainer container = ProviderScope.containerOf(context);

        container.read(writeTodoNotifierProvider.notifier).setTodo(todo!);
      });
    }

    return Scaffold(
      appBar: CustomAppbar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            TitleField(),
            Divider(),
            TagTile(),
            Divider(),
            ImagePreview(),
            AddImageButtonsRow(),
          ],
        ),
      ),
    );
  }
}
