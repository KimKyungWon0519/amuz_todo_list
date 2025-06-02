import 'package:amuz_todo_list/src/core/routes/app_routes.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/details_todo_notifier.dart';
import 'package:amuz_todo_list/src/presentation/widgets/error_dialog.dart';
import 'package:amuz_todo_list/src/presentation/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Consumer(
          builder: (context, ref, child) {
            return PopupMenuButton(
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      child: Text("수정"),
                      onTap: () {
                        final Todo todo = ref.read(detailsTodoNotifierProvider);

                        context
                            .push(AppRoutes.writeTodo.path, extra: todo)
                            .then((value) {
                              if (value != null && value is Todo) {
                                ref
                                    .read(detailsTodoNotifierProvider.notifier)
                                    .updateTodo(value);
                              }
                            });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("삭제"),
                      onTap: () => _deleteTodo(context, ref),
                    ),
                  ],
              icon: Icon(Icons.more_horiz),
            );
          },
        ),
      ],
    );
  }

  void _deleteTodo(BuildContext context, WidgetRef ref) async {
    showLoadingDialog(context);

    bool result = await ref
        .read(detailsTodoNotifierProvider.notifier)
        .deleteTodo()
        .then((value) {
          context.pop();

          return value;
        });

    if (result) {
      context.pop();
    } else {
      showErrorDialog(
        context,
        title: '삭제 실패',
        content: 'Todo 삭제에 실패했습니다. 다시 시도해주세요.',
      );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
