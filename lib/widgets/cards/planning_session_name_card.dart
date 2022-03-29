import 'package:flutter/material.dart';

class PlanningSessionNameCard extends StatelessWidget {
  final String sessionName;

  const PlanningSessionNameCard({
    Key? key,
    required this.sessionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          Text('Session: $sessionName'),
        ],
      ),
    );
  }
}
