import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/utils/logger.dart';
import 'config.dart';
import 'app.dart';

Future<void> main() async {
  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (kDebugMode || kProfileMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      Config.init(() => runApp(const KaiboApp()));
    },
    (Object error, StackTrace stackTrace) {
      Logger.print("Error FROM OUT_SIDE FRAMEWORK ");
      Logger.print("--------------------------------");
      Logger.print("Error :  $error");
      Logger.print("StackTrace :  $stackTrace");
    },
  );
}
