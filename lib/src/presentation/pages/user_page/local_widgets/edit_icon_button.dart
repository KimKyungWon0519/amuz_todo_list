import 'package:amuz_todo_list/src/presentation/pages/add_image_panel/add_image_panel.dart';
import 'package:amuz_todo_list/src/presentation/pages/user_page/local_widgets/add_user_name_dialog.dart';
import 'package:amuz_todo_list/src/presentation/riverpods/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditIconButton extends StatelessWidget {
  const EditIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _onPressed(context),
      icon: Icon(Icons.edit_rounded),
    );
  }

  void _onPressed(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => _BottomSheet(),
    );
  }
}

class _BottomSheet extends ConsumerWidget {
  const _BottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("프로필 사진 변경"),
            onTap: () async {
              String? imagePath = await showAddImageBottomSheet(context);

              if (imagePath == null) return;

              ref.read(userNotifierProvider.notifier).setImageUrl(imagePath);
            },
          ),
          ListTile(
            title: Text("이름 변경"),
            onTap: () async {
              String? name = await showAddUserNameDialog(context);

              if (name == null || name.isEmpty) return;

              ref.read(userNotifierProvider.notifier).setUserName(name);
            },
          ),
        ],
      ),
    );
  }
}
