import 'package:Lawyer/Pages/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/lawyer.dart';
import 'Models/user.dart';
import 'Pages/splashScreen.dart';
import 'Services/lawyerAuth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Lawyer>.value(
      value: LawyerAuthService().lawyer,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.pink,
          primaryColor: Colors.brown[400],
        ),
        home: SplashScreenPage(),
      ),
    );
  }
}
