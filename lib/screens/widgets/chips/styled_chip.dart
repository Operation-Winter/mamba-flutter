import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class StyledChip extends StatelessWidget {
  final String text;
  final VoidCallback? onDeleted;

  const StyledChip({
    Key? key,
    required this.text,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.all(2),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(
          text[0].toUpperCase(),
        ),
      ),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: primaryColor,
      elevation: 6,
      shadowColor: Colors.grey.shade600,
      padding: const EdgeInsets.all(8),
      onDeleted: onDeleted,
    );
  }
}
