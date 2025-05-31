import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/detail_todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddTodoPanel extends StatelessWidget {
  const AddTodoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder:
                    (context, isExpanded) => ListTile(title: Text('추가된 태그')),
                body: _SelectTag(),
                isExpanded: true,
              ),
            ],
          ),
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder:
                    (context, isExpanded) => ListTile(title: Text('모든 태그')),
                body: Wrap(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SelectTag extends ConsumerWidget {
  const _SelectTag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Set<Tag> tags = ref.watch(
      detailTodoNotifierProvider.select((value) => value.tags),
    );

    return Wrap(
      spacing: 8,
      children:
          tags.map((tag) {
            return Chip(
              label: Text(tag.name),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              clipBehavior: Clip.hardEdge,
              onDeleted: () {},
            );
          }).toList(),
    );
  }
}
