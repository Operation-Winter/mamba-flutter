import 'package:flutter/material.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningSessionParticipantsCard extends StatelessWidget {
  const PlanningSessionParticipantsCard({
    Key? key,
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
          children: const [
            TitleText(text: 'Participants'),
          ],
        ),
      ),
    );
  }
}
