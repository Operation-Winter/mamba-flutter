import 'package:flutter/foundation.dart' as Foundation;
import 'network_environment.dart';

class URLCenter {
  static NetworkEnvironment get currentEnvironment {
    if (Foundation.kReleaseMode) {
      return NetworkEnvironment.production;
    }
    return NetworkEnvironment.development;
  }

  static Uri get planningHostPath {
    return Uri.parse(currentEnvironment.baseWebsocketURL + '/planning/host');
  }

  static Uri get planningJoinPath {
    return Uri.parse(currentEnvironment.baseWebsocketURL + '/planning/join');
  }

  static Uri get planningSpectatorPath {
    return Uri.parse(
        currentEnvironment.baseWebsocketURL + '/planning/spectator');
  }
}
