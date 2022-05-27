import 'package:flutter/material.dart';
import 'package:mamba/models/planning_participant_group_dto.dart';
import 'package:mamba/widgets/rows/participant_row.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

class PlanningParticipantCommand {
  final Function(UuidValue)? onTap;
  final String title;

  PlanningParticipantCommand({
    required this.title,
    this.onTap,
  });
}

class PlanningSessionParticipantsCard extends StatelessWidget {
  late final List<PlanningParticipantGroupDto> participants;
  final List<PlanningParticipantCommand> participantCommands;
  final ParticipantRowVoteState voteState;

  PlanningSessionParticipantsCard({
    Key? key,
    required this.participants,
    required this.participantCommands,
    required this.voteState,
  }) : super(key: key) {
    for (var group in participants) {
      group.participants = group.participants.sorted((a, b) {
        var sortOrderA =
            a.votes?.isNotEmpty == true ? a.votes!.last.sortOrder + 20 : 100;
        var sortOrderB =
            b.votes?.isNotEmpty == true ? b.votes!.last.sortOrder + 20 : 100;

        if (a.highlighted) sortOrderA -= 10;
        if (b.highlighted) sortOrderB -= 10;

        return (sortOrderA).compareTo(sortOrderB);
      });
    }
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
            const TitleText(text: 'Participants'),
            const SizedBox(height: 10),
            participants.isEmpty
                ? const DescriptionText(
                    text: 'No participants have joined the session yet',
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        children: participants
                            .mapIndexed(
                              (index, participant) => Column(
                                children: [
                                  if (participant.tag != null && index > 0)
                                    const SizedBox(height: 10),
                                  if (participant.tag != null)
                                    DescriptionText(text: participant.tag!),
                                  if (participant.tag != null)
                                    const SizedBox(height: 10),
                                  if (participant.tag == null && index > 0)
                                    const SizedBox(height: 20),
                                  GridView(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          constraints.maxWidth > 500 ? 2 : 1,
                                      childAspectRatio:
                                          constraints.maxWidth > 500
                                              ? constraints.maxWidth / 100
                                              : constraints.maxWidth / 50,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: participant.participants
                                        .map(
                                          (participant) => ParticipantRow(
                                            participantId:
                                                participant.participantId,
                                            name: participant.name,
                                            connected: participant.connected,
                                            participantCommands:
                                                participantCommands,
                                            voteState: voteState,
                                            votes: participant.votes,
                                            highlighted:
                                                participant.highlighted,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
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
