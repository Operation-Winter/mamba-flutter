import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class PlanningSessionCoffeeBreakVotingCard extends StatefulWidget {
  const PlanningSessionCoffeeBreakVotingCard({super.key});

  @override
  State<PlanningSessionCoffeeBreakVotingCard> createState() =>
      _PlanningSessionCoffeeBreakVotingCardState();
}

class _PlanningSessionCoffeeBreakVotingCardState
    extends State<PlanningSessionCoffeeBreakVotingCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text("Coffee break voting card"),
    );
  }
}
