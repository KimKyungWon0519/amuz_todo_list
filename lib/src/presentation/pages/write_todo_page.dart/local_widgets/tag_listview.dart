import 'package:flutter/material.dart';

class TagListview extends StatelessWidget {
  const TagListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder:
          (context, index) => Chip(
            label: Text('태그 $index'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) => SizedBox(width: 4),
    );
  }
}
