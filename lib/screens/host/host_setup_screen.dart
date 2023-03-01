import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/screen_arguments/host_landing_screen_arguments.dart';
import 'package:mamba/screens/host/host_landing_screen.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/cards/planning_card_selectable.dart';
import 'package:mamba/widgets/inputs/styled_switch.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';
import 'package:mamba/ui_constants.dart';

class HostSetupScreen extends StatefulWidget {
  const HostSetupScreen({Key? key}) : super(key: key);
  static String route = '/host/setup';

  @override
  State<HostSetupScreen> createState() => _HostSetupScreenState();
}

class _HostSetupScreenState extends State<HostSetupScreen> {
  bool automaticallyCompleteVoting = false;
  bool validationPassed = false;
  String? sessionName;
  String? password;
  List<PlanningCard> availableCards = PlanningCard.values.toList();

  bool get formIsValid {
    return sessionName?.isEmpty == false && availableCards.isNotEmpty;
  }

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
    if (!validationPassed) return;

    Navigator.pushNamed(
      context,
      HostLandingScreen.route,
      arguments: HostLandingScreenArguments(
        sessionName: sessionName!,
        automaticallyCompleteVoting: automaticallyCompleteVoting,
        availableCards: availableCards,
        password: password,
      ),
    );
  }

  void _didTapCard(PlanningCard planningCard) {
    setState(() {
      availableCards.contains(planningCard)
          ? availableCards.remove(planningCard)
          : availableCards.add(planningCard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: maxWidth),
            child: ListView(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              iconSize: 30,
                              icon: const Icon(Icons.chevron_left),
                            ),
                            const Expanded(
                              child: TitleText(
                                text: 'Host a sizing session',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                        const DescriptionText(
                          text:
                              'Provide the details necessary start a new session below',
                        ),
                        const SizedBox(height: 10),
                        StyledTextField(
                          placeholder: 'Session name',
                          input: sessionName,
                          onChanged: sessionNameChanged,
                          autofocus: true,
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
                        const SizedBox(height: 10),
                        const Text(
                          'Available cards',
                          style: descriptionColoredTextStyle,
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          children: PlanningCard.values
                              .map((planningCard) => ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 75),
                                    child: PlanningCardSelectable(
                                        planningCard: planningCard,
                                        selected: availableCards
                                            .contains(planningCard),
                                        onTap: () {
                                          _didTapCard(planningCard);
                                        }),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        RoundedButton(
                          title: 'Start session',
                          enabled: validationPassed,
                          onPressed:
                              validationPassed ? didTapStartSession : null,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
