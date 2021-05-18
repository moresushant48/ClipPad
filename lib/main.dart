import 'package:clippad/Routes.dart';
import 'package:clippad/pages/HomePage.dart';
import 'package:clippad/services/GoogleAuth.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(Init());
}

class Init extends StatefulWidget {
  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  @override
  void initState() {
    super.initState();
    googleAuthService
        .isLoggedIn()
        .then((value) => value ? null : googleAuthService.handleSignIn());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ThemeProvider(
            saveThemesOnChange: true,
            loadThemeOnInit: true,
            child: ThemeConsumer(
              child: Builder(
                builder: (themeContext) => MaterialApp(
                  builder: OneContext().builder,
                  navigatorKey: OneContext().key,
                  theme: ThemeProvider.themeOf(themeContext).data,
                  home: HomePage(),
                  initialRoute: "/",
                  onGenerateRoute: Routes.generateRoute,
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
