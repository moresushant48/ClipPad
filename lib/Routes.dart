import 'package:clippad/pages/HomePage.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: settings, builder: (_) => HomePage());
      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => HomePage());
    }
  }
}
