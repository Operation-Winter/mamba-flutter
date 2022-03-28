import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class SessionLoadingState extends StatelessWidget {
  const SessionLoadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
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
