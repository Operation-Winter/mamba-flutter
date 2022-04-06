import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';

import '../../ui_constants.dart';

class PlanningCardSelectable extends StatelessWidget {
  final PlanningCard planningCard;
  final bool selected;
  final VoidCallback onTap;

  const PlanningCardSelectable({
    Key? key,
    required this.planningCard,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image(
            image: planningCard.image,
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: selected
                ? const Icon(
                    Icons.check_circle,
                    color: accentColor,
                  )
                : const Icon(
                    Icons.circle_rounded,
                    color: accentColor,
                  ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
