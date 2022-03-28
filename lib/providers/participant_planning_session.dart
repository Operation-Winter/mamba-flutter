import 'package:mamba/networking/url_center.dart';
import 'package:mamba/networking/web_socket_wrapper.dart';
import 'package:mamba/providers/planning_session.dart';

class SpectatorPlanningSession extends PlanningSession {
  SpectatorPlanningSession()
      : super(
          WebSocketNetworking(
            uri: URLCenter.planningSpectatorPath,
          ),
        );
}
