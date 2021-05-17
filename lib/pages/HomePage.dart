import 'dart:convert';

import 'package:clippad/model/User.dart';
import 'package:clippad/services/ClipboardService.dart';
import 'package:clippad/services/GoogleAuth.dart';
import 'package:clippad/services/SharedPrefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:one_context/one_context.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IconData fabIcon = Icons.play_arrow_sharp;
  bool isEnabled;

  @override
  void initState() {
    super.initState();
  }

  void serviceHandler() async {
    prefService
        .getSharedBool(PrefService.IS_SERVICE_ON)
        .then((isServiceOn) async {
      if (isServiceOn) {
        fabIcon = Icons.play_arrow_sharp;
        clipService.stopServiceInPlatform();
        setState(() {});
      } else {
        fabIcon = Icons.pause_sharp;
        clipService.startServiceInPlatform();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ClipPad"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: googleAuthService.getLoggedUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: OneContext().mediaQuery.size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Last Copied"),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(snapshot.data.id)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                User user = User.fromJson(
                                    jsonEncode(snapshot.data.data()));
                                return Linkify(
                                  text: user.data,
                                  onOpen: _onOpen,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18.0),
                                );
                              } else
                                return Container();
                            },
                          ),
                        ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => serviceHandler(),
        child: Icon(fabIcon),
        mini: true,
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      OneContext.instance.showSnackBar(
          builder: (_) => SnackBar(
              duration: Duration(milliseconds: 800),
              content: Text("Trying to open website.")));
      await launch(link.url);
    } else {
      OneContext.instance.showSnackBar(
          builder: (_) => SnackBar(
              duration: Duration(milliseconds: 800),
              content: Text("Couldn't open website.")));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
