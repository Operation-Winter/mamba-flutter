import 'package:flutter/material.dart';
import 'package:mamba/widgets/cards/planning_session_participants_card.dart';
import 'package:uuid/uuid.dart';

import '../../ui_constants.dart';

class ParticipantRow extends StatelessWidget {
  final UuidValue participantId;
  final String name;
  final bool connected;
  final List<PlanningParticipantCommand> participantCommands;
  final bool shouldHideVotes;

  const ParticipantRow({
    Key? key,
    required this.participantId,
    required this.name,
    required this.connected,
    required this.participantCommands,
    required this.shouldHideVotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: PopupMenuButton(
        itemBuilder: (context) => participantCommands
            .map((command) => PopupMenuItem(
                  onTap: () => command.onTap?.call(participantId),
                  child: Text(
                    command.title,
                  ),
                ))
            .toList(),
        offset: const Offset(0, 43),
        enabled: participantCommands.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              if (participantCommands.isNotEmpty) ...[
                const Icon(
                  Icons.arrow_drop_down,
                  color: disabledColor,
                )
              ],
              Icon(
                Icons.account_circle,
                color: connected ? Colors.green : Colors.red,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
