import 'package:flutter/material.dart';

class ChipWrap extends StatelessWidget {
  final List<Widget> children;

  const ChipWrap({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 6,
        children: children,
      ),
    );
  }
}
