import 'package:amuz_todo_list/src/presentation/riverpods/details_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CreateAt extends ConsumerWidget {
  const CreateAt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime createAt = ref.watch(
      detailsTodoNotifierProvider.select((value) => value.createAt),
    );

    return _DateText(type: "생성일", date: createAt);
  }
}

class UpdateAt extends ConsumerWidget {
  const UpdateAt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime? updateAt = ref.watch(
      detailsTodoNotifierProvider.select((value) => value.updateAt),
    );

    return _DateText(type: "수정일", date: updateAt);
  }
}

class _DateText extends StatelessWidget {
  final String type;
  final DateTime? date;

  const _DateText({super.key, required this.type, required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$type : ${date != null ? DateFormat.yMd("ko").format(date!) : "없음"}",
      style: TextStyle(color: Colors.grey[800]),
    );
  }
}
