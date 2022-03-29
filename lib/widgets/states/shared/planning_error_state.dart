import 'package:flutter/material.dart';

class PlanningErrorState extends StatelessWidget {
  const PlanningErrorState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Error"),
            ],
          ),
        ),
      ),
    );
  }
}
