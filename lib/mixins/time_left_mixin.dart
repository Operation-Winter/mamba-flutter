mixin TimeLeftMixin {
  int? timeLeft({
    required DateTime timeReceived,
    int? timeLeft,
  }) {
    if (timeLeft == null) return null;
    var currentTime = DateTime.now();
    var timeDifference = currentTime.difference(timeReceived).inSeconds;
    return timeLeft - timeDifference;
  }
}
