import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/compliance.dart';

class ComplianceBar extends StatelessWidget {
  final double wearTime;
  final double wearPctOfRecommended;
  final String label;

  ComplianceBar({this.label, this.wearTime, this.wearPctOfRecommended});
// const means every instance of this object will be immutable

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          //to stop bar changing size
          height: 20,
          child: FittedBox(
              //child: Text('${wearTime.toStringAsFixed(1)}'),
              ),
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: 160,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlue, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor:
                        (wearPctOfRecommended <= 1) ? wearPctOfRecommended : 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '${wearTime.toString()} hours',
              style: Theme.of(context).textTheme.bodyText1,
              textScaleFactor: 1.5,
            ),
            Text(
              label,
              textScaleFactor: 1.3,
            ),
          ],
        ),
      ],
    );
  }
}
