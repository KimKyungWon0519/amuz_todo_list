import 'package:amuz_todo_list/src/domain/model/filter_type.dart';
import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/todo_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'all_tag_list_dialog.dart';
import 'search_dialog.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("ToDo"),
      actions: [_FilterButton(), SearchIcon()],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _FilterButton extends HookConsumerWidget {
  const _FilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<FilterType> filterType = useState<FilterType>(
      AllFilterType(),
    );

    return PopupMenuButton(
      itemBuilder:
          (_) =>
              [
                  AllFilterType(),
                  IncompleteFilterType(),
                  CompleteFilterType(),
                ].map((type) {
                  return PopupMenuItem<FilterType>(
                    onTap: () {
                      filterType.value = type;

                      ref
                          .read(todoListNotifierProvider.notifier)
                          .applyFilter(type);
                    },
                    value: type,
                    child: Row(
                      children: [
                        Text(type.name),
                        Spacer(),
                        if (filterType.value == type) Icon(Icons.check),
                      ],
                    ),
                  );
                }).toList()
                ..add(
                  PopupMenuItem<FilterType>(
                    onTap: () async {
                      Tag? tag = await showAllTagListDialog(context);
                      if (tag != null) {
                        filterType.value = TagFilterType(tag);

                        ref
                            .read(todoListNotifierProvider.notifier)
                            .applyFilter(TagFilterType(tag));
                      }
                    },
                    value: TagFilterType(null),
                    child: Row(
                      children: [
                        Text("태그"),
                        Spacer(),
                        if (filterType.value is TagFilterType)
                          Text(filterType.value.name),
                      ],
                    ),
                  ),
                ),
      icon: Icon(Icons.filter_alt_rounded),
    );
  }
}

class SearchIcon extends ConsumerWidget {
  const SearchIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        String? value = await showSearchDialog(context);

        ref.read(todoListNotifierProvider.notifier).searchTodos(value);
      },
      icon: Icon(Icons.search_rounded),
    );
  }
}
