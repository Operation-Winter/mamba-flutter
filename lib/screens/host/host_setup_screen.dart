import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/screens/host/host_landing_screen.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/chips/add_chip.dart';
import 'package:mamba/widgets/chips/chip_wrap.dart';
import 'package:mamba/widgets/chips/styled_chip.dart';
import 'package:mamba/widgets/dialog/text_field_dialog.dart';
import 'package:mamba/widgets/inputs/styled_switch.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';
import 'package:mamba/ui_constants.dart';

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
  List<PlanningCard> availableCards = [];

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
    Navigator.pushNamed(context, HostLandingScreen.route,
        arguments: HostLandingScreenArguments(
          sessionName: sessionName!,
          automaticallyCompleteVoting: automaticallyCompleteVoting,
          availableCards: availableCards,
          password: password,
          tags: tags,
        ));
  }

  bool get formIsValid {
    return sessionName?.isEmpty == false;
  }

  final _textController = TextEditingController();

  void _addChip(String tag) {
    setState(() {
      tags.add(tag);
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

    styledChipList.add(
      AddChip(
        onTap: () => TextFieldAlertDialog.show(
          title: 'Add voting tag',
          placeholder: 'Enter tag name',
          primaryActionTitle: 'Add',
          context: context,
          controller: _textController,
          textFieldInput: _addChip,
        ),
      ),
    );
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        iconSize: 30,
                        padding: const EdgeInsets.only(top: 16),
                        icon: const Icon(Icons.chevron_left),
                      ),
                      const Expanded(
                        child: TitleText(
                          text: 'Host a sizing session',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        width: 48,
                      ),
                    ],
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
                  const Text(
                    'Tags',
                    style: descriptionColoredTextStyle,
                  ),
                  ChipWrap(
                    children: chipList(),
                  ),
                  //TODO: Add ability to select available cards
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
