import 'dart:io';

import 'package:clippad/services/FirestoreService.dart';
import 'package:clippad/services/GoogleAuth.dart';
import 'package:clippad/services/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard_monitor/clipboard_monitor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IconData fabIcon = Icons.play_arrow_sharp;
  bool isEnabled;
  TextEditingController _data = TextEditingController();

  @override
  void initState() {
    super.initState();
    ClipboardMonitor.registerCallback(onClipboardText);
  }

  void onClipboardText(String text) {
    setState(() {
      _data.text = text;
    });
    fireStoreService.updateData(text);
    print("clipboard changed: $text");
  }

  void serviceHandler() async {
    print("Inside Handler");
    prefService
        .getSharedBool(PrefService.IS_SERVICE_ON)
        .then((isServiceOn) async {
      print("Printing isServiceOn : " + isServiceOn.toString());
      if (isServiceOn) {
        stopServiceInPlatform();
      } else {
        startServiceInPlatform();
      }
    });
  }

  void startServiceInPlatform() async {
    if (Platform.isAndroid) {
      var methodChannel = MethodChannel("io.moresushant48.clippad");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
      prefService.putSharedBool(PrefService.IS_SERVICE_ON, true);
      fabIcon = Icons.pause_sharp;
      setState(() {});
    }
  }

  void stopServiceInPlatform() async {
    if (Platform.isAndroid) {
      var methodChannel = MethodChannel("io.moresushant48.clippad");
      String data = await methodChannel.invokeMethod("stopService");
      debugPrint(data);
      prefService.putSharedBool(PrefService.IS_SERVICE_ON, false);
      fabIcon = Icons.play_arrow_sharp;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ClipPad"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: googleAuthService.isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        TextField(
                          controller: _data,
                        ),
                      ],
                    ),
                  ),
                );
              } else
                return Center(
                  child: Column(
                    children: [
                      Text("App dosen't work without Signing In."),
                      TextButton(onPressed: () {}, child: Text("Sign In"))
                    ],
                  ),
                );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => serviceHandler(),
        child: Icon(fabIcon),
      ),
    );
  }

  @override
  void dispose() {
    ClipboardMonitor.unregisterCallback(onClipboardText);
    super.dispose();
  }
}
