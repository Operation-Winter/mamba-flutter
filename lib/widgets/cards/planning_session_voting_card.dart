import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/ui_constants.dart';

class PlanningSessionVotingCard extends StatelessWidget {
  final List<PlanningCard> planningCards;
  final PlanningCard? selectedCard;
  final Function(PlanningCard) onSelectCard;

  const PlanningSessionVotingCard({
    Key? key,
    required this.planningCards,
    this.selectedCard,
    required this.onSelectCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: planningCards
              .map(
                (planningCard) => GestureDetector(
                  onTap: () => onSelectCard(planningCard),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 75),
                    decoration: selectedCard == planningCard
                        ? BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          )
                        : null,
                    child: Image(
                      image: planningCard.image,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
