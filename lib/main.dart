import 'package:compliance_app/screens/temp.dart';

import './models/bt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:compliance_app/screens/connect_screen.dart';
import 'package:compliance_app/screens/fit_screen.dart';
import 'package:compliance_app/models/compliance.dart';
import 'package:compliance_app/screens/weeklycompliance_screen.dart';
import 'screens/info_screen.dart';
import './models/compliances.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Compliances()),
        ChangeNotifierProvider(create: (ctx) => Bt()),
      ],
      child: MaterialApp(
        title: 'Compliance App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                title: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w300,
                ),
              ),
        ),
        routes: {
          '/': (ctx) => InfoScreen(),
          FitScreen.routeName: (ctx) => FitScreen(),
          ConnectScreen.routeName: (ctx) => ConnectScreen(),
          WeeklyComplianceScreen.routeName: (ctx) => WeeklyComplianceScreen(),
          TempConnect.routeName: (ctx) => TempConnect(),
        },
      ),
    );
  }
}
