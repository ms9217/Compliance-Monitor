import 'package:compliance_app/models/compliances.dart';
import 'package:compliance_app/widgets/weekly_compliance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeeklyComplianceScreen extends StatefulWidget {
  static const routeName = '/weeklycompliance';

  @override
  _WeeklyComplianceScreenState createState() => _WeeklyComplianceScreenState();
}

class _WeeklyComplianceScreenState extends State<WeeklyComplianceScreen> {
  @override
  Widget build(BuildContext context) {
    final wearTimesData = Provider.of<Compliances>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wear time'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => wearTimesData.addSample(),
          )
        ],
      ),
      body: WeeklyCompliance(),
    );
  }
}
