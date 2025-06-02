import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text('검색'),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: '제목',
          border: OutlineInputBorder(),
        ),
        onSubmitted: (value) {
          context.pop(value);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('취소'),
        ),
      ],
    );
  }
}

Future<String?> showSearchDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) => const SearchDialog(),
  );
}