import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

enum _FilterType {
  all('전체'),
  incomplete('미완료'),
  complete('완료');

  final String name;
  const _FilterType(this.name);
}

class _FilterButton extends HookWidget {
  const _FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<_FilterType> filterType = useState<_FilterType>(
      _FilterType.all,
    );

    return PopupMenuButton(
      itemBuilder:
          (_) =>
              _FilterType.values.map((type) {
                return PopupMenuItem<_FilterType>(
                  onTap: () {
                    filterType.value = type;
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
