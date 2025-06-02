import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoadTempTodoDialog extends StatelessWidget {
  const LoadTempTodoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('임시 저장된 데이터가 있습니다.\n불러오겠습니까?'),
      actions: [
        TextButton(onPressed: () => context.pop(true), child: Text('불러오기')),
        TextButton(onPressed: () => context.pop(false), child: Text('취소')),
      ],
    );
  }
}

Future<bool> showLoadTempTodoDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (context) => LoadTempTodoDialog(),
      ) ??
      false;
}
