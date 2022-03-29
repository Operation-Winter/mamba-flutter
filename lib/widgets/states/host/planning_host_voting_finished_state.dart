import 'package:flutter/material.dart';

class PlanningHostVotingFinishedState extends StatelessWidget {
  const PlanningHostVotingFinishedState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Voting finished state"),
            ],
          ),
        ),
      ),
    );
  }
}
