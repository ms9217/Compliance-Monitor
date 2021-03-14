import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:compliance_app/models/compliances.dart';
import 'compliance_bar.dart';
import '../dummy_data.dart';

class WeeklyCompliance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wearTimesData = Provider.of<Compliances>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: wearTimesData.groupedWearTimes.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ComplianceBar(
              label: data['day'],
              wearTime: data['weartime'],
              wearPctOfRecommended:
                  (data['weartime'] as double) / DUMMY_USER.recommendedWearTime,
            ),
          );
        }).toList(),
      ),
    );
  }
}
