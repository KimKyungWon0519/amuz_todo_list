import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddUserNameDialog extends StatelessWidget {
  const AddUserNameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("이름 변경"),
      content: TextField(
        onSubmitted: (value) {
          context.pop(value);
        },
        decoration: InputDecoration(hintText: "새 이름을 입력하세요"),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text("취소")),
      ],
    );
  }
}

Future<String?> showAddUserNameDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) => const AddUserNameDialog(),
  );
}