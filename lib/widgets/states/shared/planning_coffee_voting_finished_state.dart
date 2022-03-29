import 'package:flutter/material.dart';

class PlanningCoffeeVotingFinishedState extends StatelessWidget {
  const PlanningCoffeeVotingFinishedState({Key? key}) : super(key: key);

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
