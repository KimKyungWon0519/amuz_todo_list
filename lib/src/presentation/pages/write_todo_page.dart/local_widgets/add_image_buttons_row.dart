import 'package:flutter/material.dart';

import 'add_image_button.dart';

class AddImageButtonsRow extends StatelessWidget {
  const AddImageButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemSize = constraints.maxWidth / 5.5;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: List.generate(
            5,
            (_) => AddImageButton(size: Size(itemSize, itemSize)),
          ),
        );
      },
    );
  }
}
