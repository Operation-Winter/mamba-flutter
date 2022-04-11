import 'package:flutter/material.dart';
import 'package:mamba/models/planning_participant_dto.dart';
import 'package:mamba/widgets/rows/participant_row.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';
import 'package:uuid/uuid.dart';

class PlanningParticipantCommand {
  final Function(UuidValue)? onTap;
  final String title;

  PlanningParticipantCommand({
    required this.title,
    this.onTap,
  });
}

class PlanningSessionParticipantsCard extends StatelessWidget {
  final List<PlanningParticipantDto> participants;
  final List<PlanningParticipantCommand> participantCommands;
  final bool shouldHideVotes;

  const PlanningSessionParticipantsCard({
    Key? key,
    required this.participants,
    required this.participantCommands,
    this.shouldHideVotes = true,
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
          children: [
            const TitleText(text: 'Participants'),
            const SizedBox(
              height: 10,
            ),
            participants.isEmpty
                ? const DescriptionText(
                    text: 'No participants have joined the session yet',
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints.maxWidth > 500 ? 2 : 1,
                          childAspectRatio: constraints.maxWidth > 500
                              ? constraints.maxWidth / 92
                              : constraints.maxWidth / 46,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: participants
                            .map(
                              (participant) => ParticipantRow(
                                participantId: participant.participantId,
                                name: participant.name,
                                connected: participant.connected,
                                participantCommands: participantCommands,
                                shouldHideVotes: shouldHideVotes,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
