import 'dart:io';

import 'package:flutter/material.dart';

class AddImageButton extends StatelessWidget {
  final String? path;
  final Size size;

  const AddImageButton({super.key, this.path, required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle image selection
      },
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: path == null || path!.isEmpty
            ? const _AddIcon()
            : Image.file(File(path!), fit: BoxFit.cover),
      ),
    );
  }
}

class _AddIcon extends StatelessWidget {
  const _AddIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Icon(Icons.add_a_photo, color: Colors.grey, size: 30));
  }
}
