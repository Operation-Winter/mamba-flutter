import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/ui_constants.dart';
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

class _PlanningSessionVotingCardState extends State<PlanningSessionVotingCard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late List<String> tags;
  int _initialIndex = 0;

  @override
  void initState() {
    super.initState();
    _configureTags();
    _configureTabController();
  }

  @override
  void didUpdateWidget(covariant PlanningSessionVotingCard oldWidget) {
    _configureTags();
    _configureTabController();
    super.didUpdateWidget(oldWidget);
  }

  _configureTags() {
    tags = widget.tags.toList();
    tags.sort();
  }

  _configureTabController() {
    var selectedTag = widget.selectedTag;
    if (selectedTag != null) {
      var index = tags.indexOf(selectedTag);
      _initialIndex = index == -1 ? 0 : index;
    } else {
      _initialIndex = 0;
    }

    _tabController = TabController(
      initialIndex: _initialIndex,
      length: tags.length,
      vsync: this,
    );
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _didTapCard(null);
        widget.onSelectTag(tags.elementAt(_tabController.index));
      }
    });
  }

  _didTapCard(PlanningCard? planningCard) {
    var selectedCard = planningCard ?? widget.selectedCard;
    if (selectedCard == null) return;
    _initialIndex = _tabController.index;
    var selectedTag =
        tags.isEmpty ? null : tags.elementAt(_tabController.index);
    widget.onSelectCard(
      selectedCard,
      selectedTag,
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
            if (tags.isNotEmpty) ...[
              TabBar(
                controller: _tabController,
                tabs: tags
                    .map((tag) => Tab(
                          child: Text(
                            tag,
                            style: TextStyle(
                                color: isDarkMode(context)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ))
                    .toList(),
                indicatorColor: primaryColor,
                isScrollable: true,
              ),
              const SizedBox(height: 10),
            ],
            Wrap(
              spacing: 8,
              runSpacing: 8,
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: widget.planningCards
                  .map(
                    (planningCard) => GestureDetector(
                      onTap: () => _didTapCard(planningCard),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 75),
                        decoration: widget.selectedCard == planningCard
                            ? BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(11),
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
