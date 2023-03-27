import 'package:flutter/material.dart';
import 'package:mamba/widgets/buttons/styled_icon_button.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/planning_timer_countdown.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningSessionTicketCard extends StatelessWidget {
  final String ticketTitle;
  final String? ticketDescription;
  final List<PlanningCommandButton> commands;
  final int? timeLeft;

  const PlanningSessionTicketCard({
    Key? key,
    required this.ticketTitle,
    this.ticketDescription,
    required this.commands,
    this.timeLeft,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleText(
              text: ticketTitle,
              textAlign: TextAlign.center,
            ),
            ...[
              if (ticketDescription != null &&
                  ticketDescription?.isNotEmpty == true)
                const SizedBox(height: 10),
              if (ticketDescription != null &&
                  ticketDescription?.isNotEmpty == true)
                DescriptionText(text: ticketDescription ?? ''),
              if (commands.isNotEmpty) const SizedBox(height: 10),
              if (commands.isNotEmpty || timeLeft != null)
                Row(
                  mainAxisAlignment: timeLeft != null
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (timeLeft != null)
                      PlanningTimerCountdown(timeLeft: timeLeft!),
                    if (commands.isNotEmpty)
                      Wrap(
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
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }
}
