import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/local_database_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllTagListDialog extends ConsumerWidget {
  const AllTagListDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final AsyncValue<Set<Tag>> tags = ref.watch(getAllTagsProvider);

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: tags.when(
          data:
              (data) => Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children:
                    data
                        .map(
                          (tag) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                context.pop(tag);
                              },
                              child: Chip(
                                label: Text(tag.name),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                clipBehavior: Clip.hardEdge,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
          error: (error, stackTrace) => Container(),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

Future<Tag?> showAllTagListDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => const AllTagListDialog(),
  );
}
