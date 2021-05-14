import 'package:clippad/services/GoogleAuth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  child: Card(child: TextField()),
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
    );
  }
}
