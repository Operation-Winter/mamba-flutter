import 'package:flutter/material.dart';

class AddChip extends StatelessWidget {
  final VoidCallback? onTap;

  const AddChip({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onTap,
      label: const Icon(
        Icons.add,
        size: 18,
      ),
      labelPadding: const EdgeInsets.all(3),
      backgroundColor: Colors.grey.withOpacity(0.2),
    );
  }
}
