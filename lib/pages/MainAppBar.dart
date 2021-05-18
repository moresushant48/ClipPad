import 'package:clippad/services/GoogleAuth.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

AppBar mainAppBar(BuildContext context, String appBarTitle, setState) {
  List<String> choices = [];
  return AppBar(
    title: Text(appBarTitle != null ? appBarTitle : "Clippad"),
    centerTitle: true,
    elevation: 0.0,
    actions: [
      IconButton(
          icon: Icon(Icons.logout),
          tooltip: "Logout",
          onPressed: () {
            googleAuthService.logout().then((value) {
              setState(() {});
            });
          }),
      choices.isNotEmpty
          ? PopupMenuButton<String>(
              onSelected: (choice) {
                switch (choice) {
                  default:
                    OneContext.instance.pushNamed(choice);
                }
              },
              itemBuilder: (context) {
                return choices.map((String choice) {
                  print("Path : /" + choice);
                  return PopupMenuItem<String>(
                    child: Text(choice),
                    value: "/" + choice,
                  );
                }).toList();
              },
            )
          : Container(),
    ],
  );
}
