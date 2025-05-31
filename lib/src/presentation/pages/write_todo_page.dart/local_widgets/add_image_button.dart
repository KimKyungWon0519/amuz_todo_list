import 'dart:io';

import 'package:flutter/material.dart';

class AddImageButton extends StatelessWidget {
  final String? path;
  final Size size;

  const AddImageButton({super.key, this.path, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child:
          path == null
              ? const _AddButton()
              : ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(File(path!)),
              ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Icon(Icons.add_a_photo, color: Colors.grey, size: 30));
  }
}
