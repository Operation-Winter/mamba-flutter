import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';
import 'package:universal_io/io.dart';

class HostLandingTimerScreen extends StatefulWidget {
  final Function(int timeInterval) onStartTimer;

  const HostLandingTimerScreen({
    super.key,
    required this.onStartTimer,
  });

  @override
  State<HostLandingTimerScreen> createState() => _HostLandingTimerScreenState();
}

class _HostLandingTimerScreenState extends State<HostLandingTimerScreen> {
  final _titleController = TextEditingController();
  get shouldShowBackButton => Platform.isAndroid;
  get shouldEnableStartButton =>
      _timeInterval != null && _timeInterval! <= 1800 && _timeInterval! >= 0;
  int? get _timeInterval => int.tryParse(_titleController.text);

  _didTapStartTimer() {
    if (_timeInterval == null) return;
    widget.onStartTimer(_timeInterval!);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: maxWidth),
        child: ListView(
          shrinkWrap: kIsWeb,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(
                  top: 16, bottom: 8, left: 16, right: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (shouldShowBackButton) ...[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 30,
                            icon: const Icon(Icons.chevron_left),
                          ),
                        ],
                        const Expanded(
                          child: TitleText(
                            text: 'Add timer',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (shouldShowBackButton) ...[
                          const SizedBox(width: 48),
                        ],
                      ],
                    ),
                    const DescriptionText(
                      text:
                          'Set a timeout in seconds for the voting for the ticket. Once the timer completes, the voting for all participants will be force closed and the results for the vote will be shown. Must be between 0 and 1800 seconds (30 minutes).',
                    ),
                    const SizedBox(height: 16),
                    StyledTextField(
                      placeholder: 'Time in seconds until the session ends.',
                      autofocus: true,
                      controller: _titleController,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 20),
                    RoundedButton(
                      title: 'Start timer',
                      enabled: shouldEnableStartButton,
                      onPressed: _didTapStartTimer,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
