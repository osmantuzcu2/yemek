import 'package:flutter/material.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/locator.dart';
import 'core/constants.dart';
import 'core/routes.dart';
void main() {
  runApp(Cookie(
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mc Jsi',
        theme: ThemeData(
          primaryColor: Colors.deepOrange[200],
          accentColor: Colors.deepOrange[800],
          fontFamily: 'Source Sans Pro',
        ),
        initialRoute: Constants.ROUTE_SPLASH1,
        routes: Routes.routes,
    );
  }
}
