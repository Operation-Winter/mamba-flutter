import 'package:mamba/models/host/planning_host_state.dart';
import 'package:mamba/models/messages/planning_start_session_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:mamba/networking/url_center.dart';
import 'package:mamba/networking/web_socket_wrapper.dart';
import 'package:mamba/providers/planning_session.dart';

class HostPlanningSession extends PlanningSession {
  PlanningHostState state = PlanningHostState.loading;

  HostPlanningSession({
    required String sessionName,
    String? password,
    required List<PlanningCard> availableCards,
    required bool automaticallyCompleteVoting,
    required Set<String> tags,
  }) : super(
          WebSocketNetworking(
            uri: URLCenter.planningHostPath,
          ),
          availableCards: availableCards,
          sessionName: sessionName,
          automaticallyCompleteVoting: automaticallyCompleteVoting,
        ) {
    sendStartSessionCommand();
  }

  void sendStartSessionCommand() {
    var message = PlanningStartSessionMessage(
        sessionName: sessionName ?? "Mamba Voting Session",
        autoCompleteVoting: automaticallyCompleteVoting,
        availableCards: availableCards);
    var planningCommand = PlanningCommand(
      uuid: uuid,
      type: "START_SESSION",
      message: message,
    );
    sendCommand(planningCommand);
  }

  @override
  void parseCommand(PlanningCommand planningCommand) {
    print(planningCommand.toJson().toString());
    state = PlanningHostState.noneState;
    notifyListeners();
  }
}
