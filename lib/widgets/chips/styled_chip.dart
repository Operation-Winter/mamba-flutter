import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class StyledChip extends StatelessWidget {
  final String text;
  final Function(bool)? onSelected;
  final VoidCallback? onDeleted;
  final bool? selected;

  const StyledChip({
    Key? key,
    required this.text,
    this.onSelected,
    this.onDeleted,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputChip(
      selected: selected == true,
      labelPadding: const EdgeInsets.all(3),
      label: Text(
        text,
        style: TextStyle(
          color: isDarkMode(context) ? Colors.white : Colors.black,
        ),
      ),
      selectedColor: primaryColor.withOpacity(0.5),
      elevation: 6,
      shadowColor: Colors.grey.shade600,
      padding: const EdgeInsets.all(8),
      onSelected: onSelected,
      onDeleted: onDeleted,
      deleteIconColor:
          isDarkMode(context) ? Colors.grey.shade200 : Colors.black,
    );
  }
}
