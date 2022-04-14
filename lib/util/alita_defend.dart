import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AlitaDefend {
  /// TODO 通过接口上报异常
  _reportError(Object error, StackTrace s) {
    log("开发环境:$kDebugMode");
    log("线上环境:$kReleaseMode");
    if (kDebugMode) {
      log('kReleaseMode:$kReleaseMode');
      log('catch error:$error');
    }
  }

  run(Widget app) {
    //框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      //线上环境，走上报逻辑
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      } else {
        //开发期间，走Console抛出
        FlutterError.dumpErrorToConsole(details);
      }
    };
    runZonedGuarded(() {
      runApp(app);
    }, (e, s) => _reportError(e, s));
  }
}