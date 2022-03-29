import 'package:flutter/material.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/cards/planning_session_participants_card.dart';

class PlanningHostNoneState extends StatelessWidget {
  final String sessionName;

  const PlanningHostNoneState({
    Key? key,
    required this.sessionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            PlanningSessionNameCard(
              sessionName: sessionName,
            ),
            const PlanningSessionParticipantsCard(),
          ],
        ),
      ),
    );
  }
}
