import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/ui_constants.dart';

class PlanningCardIcon extends StatelessWidget {
  const PlanningCardIcon({
    Key? key,
    required this.planningCard,
  }) : super(key: key);

  final PlanningCard planningCard;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: true,
      verticalOffset: 60,
      message: 'Card ${planningCard.title}',
      child: AspectRatio(
        aspectRatio: 570 / 890,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: isDarkMode(context) ? darkPurple : primaryColor,
            child: Center(
              child: Text(
                planningCard.title,
                style: const TextStyle(
                  color: accentColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
