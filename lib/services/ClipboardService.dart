import 'dart:io';

import 'package:clipboard_monitor/clipboard_monitor.dart';
import 'package:clippad/services/FirestoreService.dart';
import 'package:clippad/services/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_context/one_context.dart';

class ClipboardService {
  void onClipboardText(String text) {
    fireStoreService.updateData(text);
    print("clipboard changed: $text");
  }

  void startServiceInPlatform() async {
    if (Platform.isAndroid) {
      var methodChannel = MethodChannel("io.moresushant48.clippad");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
      prefService.putSharedBool(PrefService.IS_SERVICE_ON, true);
      ClipboardMonitor.registerCallback(onClipboardText);
      OneContext.instance.showSnackBar(
          builder: (_) => SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text("Service Started")));
    }
  }

  void stopServiceInPlatform() async {
    if (Platform.isAndroid) {
      var methodChannel = MethodChannel("io.moresushant48.clippad");
      String data = await methodChannel.invokeMethod("stopService");
      debugPrint(data);
      prefService.putSharedBool(PrefService.IS_SERVICE_ON, false);
      ClipboardMonitor.unregisterCallback(onClipboardText);
      OneContext.instance.showSnackBar(
          builder: (_) => SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text("Service Stopped")));
    }
  }
}

final clipService = ClipboardService();
