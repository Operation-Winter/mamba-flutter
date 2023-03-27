import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mamba/widgets/info/icon_info.dart';

class PlanningTimerCountdown extends StatefulWidget {
  final int timeLeft;
  const PlanningTimerCountdown({
    super.key,
    required this.timeLeft,
  });

  @override
  State<PlanningTimerCountdown> createState() => _PlanningTimerCountdownState();
}

class _PlanningTimerCountdownState extends State<PlanningTimerCountdown> {
  late Duration _timeLeft;
  Timer? timer;

  String get _formattedTimeLeft =>
      '${_timeLeft.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_timeLeft.inSeconds.remainder(60).toString().padLeft(2, '0')}';

  @override
  void initState() {
    _timeLeft = Duration(seconds: widget.timeLeft);
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => setState(() {
        _timeLeft = _timeLeft - const Duration(seconds: 1);
      }),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconInfo(
      icon: Icons.timer,
      info: _formattedTimeLeft,
    );
  }
}
