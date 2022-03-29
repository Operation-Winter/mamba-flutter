import 'package:flutter/material.dart';

class PlanningHostNoneState extends StatelessWidget {
  const PlanningHostNoneState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("None state"),
            ],
          ),
        ),
      ),
    );
  }
}
