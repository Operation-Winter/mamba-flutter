import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: const [
          Text('Participants'),
        ],
      ),
    );
  }
}
