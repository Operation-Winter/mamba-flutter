import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class StyledChip extends StatelessWidget {
  final String text;
  final VoidCallback? onDeleted;
  final bool? selected;

  const StyledChip({
    Key? key,
    required this.text,
    this.onDeleted,
    this.selected,
  }) : super(key: key);

  Widget? get _avatar {
    if (selected != null) {
      return selected == true
          ? const CircleAvatar(
              backgroundColor: Colors.white70,
              radius: 12,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  Icons.check,
                  color: primaryColor,
                  size: 20,
                ),
              ),
            )
          : const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white70,
            );
    } else {
      return CircleAvatar(
        radius: 12,
        backgroundColor: Colors.grey.shade200,
        child: Text(
          text[0].toUpperCase(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.all(3),
      avatar: _avatar,
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
      deleteIconColor: Colors.grey.shade200,
    );
  }
}
