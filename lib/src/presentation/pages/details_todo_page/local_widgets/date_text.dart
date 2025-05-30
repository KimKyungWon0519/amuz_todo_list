import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAt extends StatelessWidget {
  const CreateAt({super.key});

  @override
  Widget build(BuildContext context) {
    return _DateText(type: "생성일", date: DateTime.now());
  }
}

class UpdateAt extends StatelessWidget {
  const UpdateAt({super.key});

  @override
  Widget build(BuildContext context) {
    return _DateText(type: "수정일", date: DateTime.now());
  }
}

class _DateText extends StatelessWidget {
  final String type;
  final DateTime date;

  const _DateText({super.key, required this.type, required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$type : ${DateFormat.yMd("ko").format(date)}",
      style: TextStyle(color: Colors.grey[800]),
    );
  }
}
