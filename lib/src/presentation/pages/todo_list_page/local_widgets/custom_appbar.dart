import 'package:amuz_todo_list/src/domain/model/filter_type.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/todo_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("ToDo"),
      actions: [
        _FilterButton(),
        IconButton(onPressed: null, icon: Icon(Icons.search_rounded)),
      ],
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
      FilterType.all,
    );

    return PopupMenuButton(
      itemBuilder:
          (_) =>
              FilterType.values.map((type) {
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
              }).toList(),
      icon: Icon(Icons.filter_alt_rounded),
    );
  }
}
