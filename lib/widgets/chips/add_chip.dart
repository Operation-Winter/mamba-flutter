import 'package:flutter/material.dart';

class AddChip extends StatelessWidget {
  final VoidCallback? onTap;

  const AddChip({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: const Icon(Icons.add),
        labelPadding: const EdgeInsets.all(3),
        backgroundColor: Colors.grey.withOpacity(0.2),
      ),
    );
  }
}
