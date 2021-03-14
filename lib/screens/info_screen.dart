import 'package:compliance_app/screens/connect_screen.dart';
import 'package:compliance_app/screens/temp.dart';
import 'package:compliance_app/screens/weeklycompliance_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:compliance_app/widgets/compliance_bar.dart';
import '../dummy_data.dart';
import 'fit_screen.dart';
import '../models/compliance.dart';

class InfoScreen extends StatelessWidget {
  static const routeName = '/info';

  var time = DateFormat.Hms().format(DateTime.now());

  var day = DateFormat.yMd().format(DateTime.now());

  var wearPct = DUMMY_COMPLIANCE.wearTime / DUMMY_USER.recommendedWearTime;

  void selectFitScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      FitScreen.routeName,
    );
  }

  void selectWeeklyComplianceScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      WeeklyComplianceScreen.routeName,
    );
  }

  void selectConnectScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      TempConnect.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('Welcome ${DUMMY_USER.name}!'),
          alignment: Alignment.topCenter,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
              width: 20,
            ),
            FlatButton(
              onPressed: () {},
              //child: Text('Your device'),
            ),
            FlatButton(
              onPressed: () {},
              //child: Text('Visit Shop'),
            ),
            SizedBox(
              height: 30,
              width: 30,
            ),
            //Text('Your wear time for $day:'),
            Text('Refreshed: ${time}'),
            SizedBox(
              height: 5,
              width: 40,
            ),
            //ComplianceBar(
            //  label: DateFormat.E().format(DateTime.now()),
            //  wearTime: DUMMY_COMPLIANCE.wearTime,
            //  wearPctOfRecommended: wearPct,
            //),
            //TextButton(
            //  onPressed: () => selectWeeklyComplianceScreen(context),
            //  child: Text('More info'),
            //),
            SizedBox(
              height: 20,
            ),
            // Text(
            //   'You\'re almost there!',
            // ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 50,
              child: OutlineButton(
                onPressed: () => selectWeeklyComplianceScreen(context),
                child: Text('Check your wear time'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 300,
                height: 50,
                child: OutlineButton(
                  onPressed: () => selectFitScreen(context),
                  child: Text('Check your fit'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              width: 300,
              height: 50,
              child: OutlineButton(
                onPressed: () => selectConnectScreen(context),
                child: Text('Connect your device'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
