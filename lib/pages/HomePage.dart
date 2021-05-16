import 'package:clippad/services/ClipboardService.dart';
import 'package:clippad/services/GoogleAuth.dart';
import 'package:clippad/services/SharedPrefs.dart';
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
  String _data = "";

  @override
  void initState() {
    super.initState();
    initialData();
  }

  initialData() {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      setState(() {
        _data = value.text;
      });
    });
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
          future: googleAuthService.isLoggedIn(),
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
                          child: Linkify(
                            text: _data,
                            onOpen: _onOpen,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0),
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
