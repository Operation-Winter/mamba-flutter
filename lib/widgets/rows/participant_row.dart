import 'package:flutter/material.dart';
import 'package:mamba/widgets/cards/planning_session_participants_card.dart';
import 'package:uuid/uuid.dart';

import '../../ui_constants.dart';

enum ParticipantRowVoteState { hidden, obfuscated, visible }

class ParticipantRow extends StatelessWidget {
  final UuidValue participantId;
  final String name;
  final bool connected;
  final List<String>? votes;
  final List<PlanningParticipantCommand> participantCommands;
  final ParticipantRowVoteState voteState;

  const ParticipantRow({
    Key? key,
    required this.participantId,
    required this.name,
    required this.connected,
    required this.participantCommands,
    required this.voteState,
    this.votes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
              const SizedBox(width: 10),
              Text(name),
              const Spacer(),
              ..._voteWidget(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _voteWidget() {
    switch (voteState) {
      case ParticipantRowVoteState.hidden:
        return [];
      case ParticipantRowVoteState.obfuscated:
        return [
          votes == null
              ? const Icon(
                  Icons.more_horiz,
                  color: disabledColor,
                )
              : votes?.isNotEmpty == true
                  ? const Icon(
                      Icons.check,
                      color: disabledColor,
                    )
                  : const Icon(
                      Icons.redo,
                      color: disabledColor,
                    )
        ];
      case ParticipantRowVoteState.visible:
        return [];
    }
  }
}
