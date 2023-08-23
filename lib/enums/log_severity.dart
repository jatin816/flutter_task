enum LogSeverity { Trace, Info, Error, Fatal }

extension LogSeverityExtension on LogSeverity {
  String string() {
    switch (this) {
      case LogSeverity.Trace:
        return "LOG TRACE";
      case LogSeverity.Info:
        return "LOG INFO";
      case LogSeverity.Error:
        return "LOG ERROR";
      case LogSeverity.Fatal:
        return "LOG FATAL";
      default:
        return "";
    }
  }
}
