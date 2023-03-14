import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/chips/chip_wrap.dart';
import 'package:mamba/widgets/chips/styled_chip.dart';
import 'package:mamba/widgets/planning_card_icon.dart';
import 'dart:core';

class PlanningSessionVotingCard extends StatefulWidget {
  final List<PlanningCard> planningCards;
  final PlanningCard? selectedCard;
  final String? selectedTag;
  final Set<String> tags;
  final Function(PlanningCard, String?) onSelectCard;
  final Function(String) onSelectTag;

  const PlanningSessionVotingCard({
    Key? key,
    required this.planningCards,
    required this.tags,
    this.selectedCard,
    this.selectedTag,
    required this.onSelectCard,
    required this.onSelectTag,
  }) : super(key: key);

  @override
  State<PlanningSessionVotingCard> createState() =>
      _PlanningSessionVotingCardState();
}

class _PlanningSessionVotingCardState extends State<PlanningSessionVotingCard> {
  late List<String> _tags;
  late String? _selectedTag;

  @override
  void initState() {
    super.initState();
    _configureTags();
  }

  @override
  void didUpdateWidget(covariant PlanningSessionVotingCard oldWidget) {
    _configureTags();
    super.didUpdateWidget(oldWidget);
  }

  _configureTags() {
    _tags = widget.tags.toList();
    _tags.sort();
    _selectedTag = widget.selectedTag ?? _tags.firstOrNull;
  }

  _didTapCardOrTag({
    PlanningCard? planningCard,
    String? tag,
  }) {
    _didTapTag(tag: tag);
    _didTapCard(planningCard: planningCard);
  }

  _didTapTag({
    String? tag,
  }) {
    setState(() {
      _selectedTag = tag;
    });

    if (tag == null) return;
    widget.onSelectTag(tag);
  }

  _didTapCard({
    PlanningCard? planningCard,
  }) {
    var selectedCard = planningCard ?? widget.selectedCard;

    if (selectedCard == null) return;
    widget.onSelectCard(
      selectedCard,
      _selectedTag,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_tags.isNotEmpty) ...[
              ChipWrap(
                children: _tags
                    .map((tag) => StyledChip(
                          text: tag,
                          selected: tag == _selectedTag,
                          onSelected: (_) => _didTapCardOrTag(
                            planningCard: null,
                            tag: tag,
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 10),
            ],
            Wrap(
              spacing: 8,
              runSpacing: 8,
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: widget.planningCards
                  .map(
                    (planningCard) => GestureDetector(
                      onTap: () => _didTapCardOrTag(
                        planningCard: planningCard,
                        tag: _selectedTag,
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth:
                                widget.selectedCard == planningCard ? 85 : 75),
                        decoration: widget.selectedCard == planningCard
                            ? BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color: primaryColorSelection,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ],
                              )
                            : null,
                        child: PlanningCardIcon(planningCard: planningCard),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
