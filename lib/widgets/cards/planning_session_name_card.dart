import 'package:flutter/material.dart';
import 'package:mamba/widgets/buttons/styled_icon_button.dart';
import 'package:mamba/widgets/info/icon_info.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningCommandButton {
  final VoidCallback? onPressed;
  final IconData icon;
  final String tooltip;

  PlanningCommandButton({
    required this.icon,
    required this.tooltip,
    this.onPressed,
  });
}

class PlanningSessionNameCard extends StatelessWidget {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCommandButton> commands;

  const PlanningSessionNameCard({
    Key? key,
    required this.sessionName,
    required this.commands,
    required this.coffeeVoteCount,
    required this.spectatorCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleText(text: sessionName),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      IconInfo(icon: Icons.coffee, info: '$coffeeVoteCount'),
                      IconInfo(icon: Icons.visibility, info: '$spectatorCount'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
        ),
      ),
    );
  }
}
