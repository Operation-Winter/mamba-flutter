import 'package:flutter/material.dart';
import 'package:mamba/widgets/buttons/styled_icon_button.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/chips/chip_wrap.dart';
import 'package:mamba/widgets/chips/styled_chip.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningSessionTicketCard extends StatelessWidget {
  final String ticketTitle;
  final String? ticketDescription;
  final Set<String> selectedTags;
  final List<PlanningCommandButton> commands;

  const PlanningSessionTicketCard({
    Key? key,
    required this.ticketTitle,
    this.ticketDescription,
    required this.selectedTags,
    required this.commands,
  }) : super(key: key);

  List<Widget> chipList() {
    List<Widget> styledChipList = selectedTags
        .map(
          (tag) => StyledChip(text: tag),
        )
        .cast<Widget>()
        .toList();
    return styledChipList;
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleText(text: ticketTitle, textAlign: TextAlign.center),
            ...[
              if (ticketDescription != null &&
                  ticketDescription?.isNotEmpty == true)
                const SizedBox(height: 10),
              if (ticketDescription != null &&
                  ticketDescription?.isNotEmpty == true)
                DescriptionText(text: ticketDescription ?? ''),
              if (commands.isNotEmpty || selectedTags.isNotEmpty)
                const SizedBox(height: 10),
              if (commands.isNotEmpty || selectedTags.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (selectedTags.isNotEmpty)
                      Expanded(
                        flex: 1,
                        child: ChipWrap(
                          children: chipList(),
                        ),
                      ),
                    if (commands.isNotEmpty)
                      Expanded(
                        flex: 2,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          direction: Axis.horizontal,
                          spacing: 8,
                          runSpacing: 8,
                          children: commands
                              .map(
                                (command) => StyledIconButton(
                                  icon: command.icon,
                                  tooltip: command.tooltip,
                                  onPressed: command.onPressed,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }
}
