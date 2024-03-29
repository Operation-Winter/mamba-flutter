import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class PlanningLoadingState extends StatelessWidget {
  const PlanningLoadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitSpinningLines(
                color: primaryColor,
                size: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
