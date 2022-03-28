enum NetworkEnvironment { development, production }

extension ExtensionNetworkEnvironment on NetworkEnvironment {
  String get baseWebsocketURL {
    switch (this) {
      case NetworkEnvironment.development:
        return 'ws://localhost:8080/api';
      case NetworkEnvironment.production:
        return 'wss://mamba.armandkamffer.co.za/api';
    }
  }
}
