// ignore: library_prefixes
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
    return Uri.parse('${currentEnvironment.baseWebsocketURL}/planning/host');
  }

  static Uri get planningJoinPath {
    return Uri.parse('${currentEnvironment.baseWebsocketURL}/planning/join');
  }

  static Uri get planningSpectatorPath {
    return Uri.parse(
        '${currentEnvironment.baseWebsocketURL}/planning/spectator');
  }

  static Uri sharePath({required String sessionCode, String? password}) {
    var urlPath =
        '${currentEnvironment.baseURL}/planning/share?sessionCode=$sessionCode';
    if (password != null) {
      '$urlPath&password=$password';
    }
    return Uri.parse(urlPath);
  }
}
