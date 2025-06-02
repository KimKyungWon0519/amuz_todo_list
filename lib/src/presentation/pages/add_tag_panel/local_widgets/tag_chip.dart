import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final Tag tag;
  final VoidCallback? onDeleted;
  final VoidCallback? onTap;

  const TagChip({super.key, required this.tag, this.onDeleted, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(tag.name),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        clipBehavior: Clip.hardEdge,
        onDeleted: onDeleted,
      ),
    );
  }
}
