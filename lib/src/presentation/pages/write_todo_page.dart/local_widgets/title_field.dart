import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  const TitleField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: '제목'),
      onTapUpOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}
