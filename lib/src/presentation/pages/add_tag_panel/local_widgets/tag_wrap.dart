import 'package:flutter/material.dart';

class TagWrap extends StatelessWidget {
  final List<Widget> children;

  const TagWrap({super.key, required this.children});

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
