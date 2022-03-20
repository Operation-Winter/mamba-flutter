import 'package:flutter/material.dart';

class AddChip extends StatelessWidget {
  final VoidCallback? onTap;

  const AddChip({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Chip(label: Icon(Icons.add)),
      onTap: onTap,
    );
  }
}
