import 'package:amuz_todo_list/src/core/constants/app_constant.dart';
import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/presentation/pages/add_tag_panel/add_tag_panel.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/detail_todo_notifier.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/local_database_notifier.dart';
import 'package:amuz_todo_list/src/presentation/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'tag_chip.dart';
import 'tag_wrap.dart';

part 'all_tags.g.dart';

@riverpod
Stream<Set<Tag>> getAllTagsExcludingSelected(Ref ref) async* {
  final Set<Tag> selectedTag = ref.watch(
    detailTodoNotifierProvider.select((value) => value.todo.tags),
  );

  final Stream<Set<Tag>> allTagsStream = ref.watch(watchAllTagsProvider.stream);

  await for (final Set<Tag> allTags in allTagsStream) {
    yield allTags..removeAll(selectedTag);
  }
}

class AllTag extends ConsumerWidget {
  const AllTag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Set<Tag>> allTags = ref.watch(
      getAllTagsExcludingSelectedProvider,
    );

    return Column(
      spacing: 8,
      children: [
        const _AddTagField(),
        allTags.when(
          data:
              (data) => TagWrap(
                children:
                    data
                        .map(
                          (tag) => TagChip(
                            tag: tag,
                            onDeleted: () => _deleteTag(ref, tag, context),
                            onTap:
                                () => ref
                                    .read(detailTodoNotifierProvider.notifier)
                                    .selectedTag(tag),
                          ),
                        )
                        .toList(),
              ),
          error: (_, __) => Container(),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  void _deleteTag(WidgetRef ref, Tag tag, BuildContext context) async {
    bool result = await ref
        .read(detailTodoNotifierProvider.notifier)
        .deleteTag(tag);

    if (!result && context.mounted) {
      showDialog(
        context: context,
        builder:
            (_) => ErrorDialog(title: '태그 삭제 실패', content: '태그를 삭제할 수 없습니다.'),
      );
    }
  }
}

class _AddTagField extends HookConsumerWidget {
  const _AddTagField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = useTextEditingController();

    return TextField(
      controller: controller,
      maxLength: tagMaxLength,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
        hintText: '추가할 태그 이름을 입력해주세요.',
      ),
      onSubmitted: (value) async {
        if (await _addTag(ref, value, context)) {
          controller.clear();
          FocusScope.of(context).unfocus();
        }
      },
      onTapUpOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }

  Future<bool> _addTag(
    WidgetRef ref,
    String value,
    BuildContext context,
  ) async {
    bool result = await ref
        .read(detailTodoNotifierProvider.notifier)
        .addTag(value);

    if (!result && context.mounted) {
      showDialog(
        context: context,
        builder:
            (_) => ErrorDialog(title: '태그 추가 실패', content: '이미 존재하는 태그입니다.'),
      );

      return false;
    }

    return true;
  }
}
