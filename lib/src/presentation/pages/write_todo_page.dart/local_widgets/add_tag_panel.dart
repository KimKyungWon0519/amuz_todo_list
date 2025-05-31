import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/detail_todo_notifier.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/local_database_notifier.dart';
import 'package:amuz_todo_list/src/presentation/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

class _AllTag extends ConsumerWidget {
  const _AllTag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Set<Tag>> tags = ref.watch(watchAllTagsProvider);

    return Column(
      spacing: 8,
      children: [
        SearchBar(
          elevation: WidgetStatePropertyAll(0.0),
          hintText: '추가할 태그 이름을 입력해주세요.',
          onSubmitted: (value) => _addTag(ref, value, context),
        ),
        tags.when(
          data:
              (data) => SizedBox(
                width: double.infinity,
                child: Wrap(
                  runAlignment: WrapAlignment.start,
                  spacing: 8,
                  children:
                      data
                          .map(
                            (e) => Chip(
                              label: Text(e.name),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              clipBehavior: Clip.hardEdge,
                              onDeleted: () => _deleteTag(ref, e, context),
                            ),
                          )
                          .toList(),
                ),
              ),
          error: (_, __) => Container(),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  void _addTag(WidgetRef ref, String value, BuildContext context) async {
    bool result = await ref
        .read(detailTodoNotifierProvider.notifier)
        .addTag(value);

    if (!result && context.mounted) {
      showDialog(
        context: context,
        builder:
            (_) => ErrorDialog(title: '태그 추가 실패', content: '이미 존재하는 태그입니다.'),
      );
    }
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
