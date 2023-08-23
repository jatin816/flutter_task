import 'package:flutter/foundation.dart';

import '../enums/log_severity.dart';

class LogUtil {
  static printLog(
      {required String message,
      required String methodName,
      required String className,
      required LogSeverity logSeverity}) async {
    if (kDebugMode) {
      print('\n${logSeverity.string()}: $className | $methodName | $message');
    }
  }
}
