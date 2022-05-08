import 'package:universal_io/io.dart';

enum NetworkEnvironment { development, production }

extension ExtensionNetworkEnvironment on NetworkEnvironment {
  String get baseWebsocketURL {
    switch (this) {
      case NetworkEnvironment.development:
        return Platform.isAndroid
            ? 'ws://10.0.2.2:8080/api'
            : 'ws://localhost:8080/api';
      case NetworkEnvironment.production:
        return 'wss://mamba.armandkamffer.co.za/api';
    }
  }

  String get baseURL {
    return 'https://mamba.armandkamffer.co.za';
  }
}
