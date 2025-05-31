import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/detail_todo_notifier.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/local_database_notifier.dart';
import 'package:amuz_todo_list/src/presentation/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_tag_panel.g.dart';

@riverpod
Stream<Set<Tag>> getAllTagsExcludingSelected(Ref ref) async* {
  final Set<Tag> selectedTag = ref.watch(
    detailTodoNotifierProvider.select((value) => value.tags),
  );

  final Stream<Set<Tag>> allTagsStream = ref.watch(watchAllTagsProvider.stream);

  await for (final Set<Tag> allTags in allTagsStream) {
    yield allTags..removeAll(selectedTag);
  }
}

class AddTodoPanel extends HookWidget {
  const AddTodoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<bool>> isOpenState = useState([false, false]);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            children: [
              _customExpansionPanel(
                '추가된 태그',
                _SelectTag(),
                isOpenState.value[0],
              ),
              _customExpansionPanel('모든 태그', _AllTag(), isOpenState.value[1]),
            ],
            expansionCallback:
                (panelIndex, isExpanded) =>
                    _updateExpandedState(panelIndex, isExpanded, isOpenState),
          ),
        ),
      ),
    );
  }

  ExpansionPanel _customExpansionPanel(
    String title,
    Widget body,
    bool isExpanded,
  ) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) => ListTile(title: Text(title)),
      body: Padding(padding: const EdgeInsets.all(16.0), child: body),
      isExpanded: isExpanded,
    );
  }

  void _updateExpandedState(
    int panelIndex,
    bool isExpanded,
    ValueNotifier<List<bool>> state,
  ) {
    List<bool> updateState = state.value.toList();

    updateState[panelIndex] = isExpanded;

    state.value = updateState;
  }
}

class _SelectTag extends ConsumerWidget {
  const _SelectTag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Set<Tag> tags = ref.watch(
      detailTodoNotifierProvider.select((value) => value.tags),
    );

    return _TagWrap(
      children:
          tags
              .map(
                (tag) => _TagChip(
                  tag: tag,
                  onDeleted: () {
                    ref
                        .read(detailTodoNotifierProvider.notifier)
                        .unselectedTag(tag);
                  },
                ),
              )
              .toList(),
    );
  }
}

class _AllTag extends ConsumerWidget {
  const _AllTag({super.key});

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
              (data) => _TagWrap(
                children:
                    data
                        .map(
                          (tag) => _TagChip(
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
      maxLength: 10,
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

class _TagChip extends StatelessWidget {
  final Tag tag;
  final VoidCallback? onDeleted;
  final VoidCallback? onTap;

  const _TagChip({super.key, required this.tag, this.onDeleted, this.onTap});

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

class _TagWrap extends StatelessWidget {
  final List<Widget> children;

  const _TagWrap({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        runAlignment: WrapAlignment.start,
        spacing: 8,
        children: children,
      ),
    );
  }
}
