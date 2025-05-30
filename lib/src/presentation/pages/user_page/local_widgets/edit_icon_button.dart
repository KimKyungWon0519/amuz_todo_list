import 'package:flutter/material.dart';

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

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: Text("프로필 사진 변경")),
          ListTile(title: Text("이름 변경")),
        ],
      ),
    );
  }
}
