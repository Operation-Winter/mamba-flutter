import 'package:flutter/material.dart';

class PlanningHostVotingState extends StatelessWidget {
  const PlanningHostVotingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Voting state"),
            ],
          ),
        ),
      ),
    );
  }
}
