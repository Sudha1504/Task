mixin LoggerMixin {
  void log(String message) {
    final timestamp = DateTime.now().toIso8601String();
    print("[$timestamp] $message");
  }
}
