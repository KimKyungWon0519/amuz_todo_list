import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/details_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'local_widgets/todo_title.dart';
import 'local_widgets/custom_appbar.dart';
import 'local_widgets/date_text.dart';
import 'local_widgets/image_panel.dart';

class DetailsTodoPage extends StatelessWidget {
  final Todo todo;

  const DetailsTodoPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      ProviderContainer container = ProviderScope.containerOf(context);

      container
          .read(detailsTodoNotifierProvider.notifier)
          .updateTodo(todo);
    });

    return Scaffold(
      appBar: CustomAppbar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TodoTitle(),
                  Spacer(),
                  Checkbox(value: false, onChanged: null),
                ],
              ),
              SizedBox(height: 8),
              CreateAt(),
              UpdateAt(),
              Spacer(),
              ImagePanel(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
