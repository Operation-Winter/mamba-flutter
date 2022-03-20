import 'package:flutter/material.dart';
import 'package:mamba/screens/host/host_landing_screen.dart';
import 'package:mamba/screens/widgets/buttons/rounded_button.dart';
import 'package:mamba/screens/widgets/chips/add_chip.dart';
import 'package:mamba/screens/widgets/chips/chip_wrap.dart';
import 'package:mamba/screens/widgets/inputs/styled_switch.dart';
import 'package:mamba/screens/widgets/inputs/styled_text_field.dart';
import 'package:mamba/screens/widgets/chips/styled_chip.dart';
import 'package:mamba/screens/widgets/text/description_text.dart';
import 'package:mamba/screens/widgets/text/title_text.dart';

class HostSetupScreen extends StatefulWidget {
  const HostSetupScreen({Key? key}) : super(key: key);
  static String route = '/host/setup';

  @override
  _HostSetupScreenState createState() => _HostSetupScreenState();
}

class _HostSetupScreenState extends State<HostSetupScreen> {
  bool automaticallyCompleteVoting = false;
  bool validationPassed = false;
  String? sessionName;
  String? password;
  Set<String> tags = {};

  void automaticallyCompleteVotingChanged(bool newValue) {
    automaticallyCompleteVoting = newValue;
  }

  void sessionNameChanged(String? newValue) {
    sessionName = newValue;
    setState(() {
      validationPassed = formIsValid;
    });
  }

  void didTapStartSession() {
    Navigator.pushNamed(context, HostLandingScreen.route);
  }

  bool get formIsValid {
    return sessionName?.isEmpty == false;
  }

  void addChip() {
    // TODO: Display pop up with text input
    setState(() {
      tags.add('MSRV');
      tags.add('MSRV1');
      tags.add('MSRV2');
      tags.add('MSRV3');
      tags.add('MSRV4');
      tags.add('MSRV5');
      tags.add('MSRV6');
      tags.add('MSRV7');
    });
  }

  List<Widget> chipList() {
    List<Widget> styledChipList = tags
        .map((tag) => StyledChip(
              text: tag,
              onDeleted: () => setState(() {
                tags.remove(tag);
              }),
            ))
        .cast<Widget>()
        .toList();

    styledChipList.add(AddChip(
      onTap: addChip,
    ));
    return styledChipList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TitleText(
                    text: 'Host a sizing session',
                  ),
                  const DescriptionText(
                      text:
                          'Provide the details necessary start a new session below'),
                  StyledTextField(
                    placeholder: 'Session name',
                    input: sessionName,
                    onChanged: sessionNameChanged,
                  ),
                  StyledTextField(
                    placeholder: 'Password (Optional)',
                    input: password,
                    onChanged: (password) {
                      this.password = password;
                    },
                  ),
                  StyledSwitch(
                    text:
                        'Automatically finish voting when all participants have voted',
                    value: automaticallyCompleteVoting,
                    onChanged: automaticallyCompleteVotingChanged,
                  ),
                  const Text('Tags'),
                  ChipWrap(
                    children: chipList(),
                  ),
                  Row(
                    children: [
                      // TODO: Implement card selection
                      Text('Available cards placeholder'),
                    ],
                  ),
                  RoundedButton(
                    title: 'Start session',
                    enabled: validationPassed,
                    onPressed: validationPassed ? didTapStartSession : null,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
