class SpectatorLandingScreenArguments {
  final String? sessionCode;
  final String? password;
  final bool reconnect;

  SpectatorLandingScreenArguments({
    this.sessionCode,
    this.password,
    this.reconnect = false,
  });
}
