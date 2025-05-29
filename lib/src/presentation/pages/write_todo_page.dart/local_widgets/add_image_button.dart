import 'package:flutter/material.dart';

class AddImageButton extends StatelessWidget {
  final Size size;

  const AddImageButton({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Image.network(
        "https://storage.googleapis.com/cms-storage-bucket/22b6ce6f012cb7ee44bb.png",
      ),
    );
  }
}
