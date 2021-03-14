import 'package:compliance_app/models/compliance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'compliance.dart';

class Compliances with ChangeNotifier {
  List<Compliance> _samples = [
    Compliance(
      date: DateTime.now().subtract(
        Duration(days: 1),
      ),
      wearTime: 6.7,
    ),
    Compliance(
      date: DateTime.now().subtract(
        Duration(days: 3),
      ),
      wearTime: 1.4,
    ),
    Compliance(
      date: DateTime.now().subtract(
        Duration(days: 1),
      ),
      wearTime: 8.0,
    ),
    Compliance(
      date: DateTime.now().subtract(
        Duration(days: 4),
      ),
      wearTime: 0.7,
    ),
  ];

  List<Compliance> get weeklySamples {
    return [..._samples].where((wt) {
      return wt.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  List<Map<String, Object>> get groupedWearTimes {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        var totalWeartime = 0.0;

        for (var i = 0; i < weeklySamples.length; i++) {
          if (weeklySamples[i].date.day == weekDay.day &&
              weeklySamples[i].date.month == weekDay.month &&
              weeklySamples[i].date.year == weekDay.year) {
            totalWeartime += weeklySamples[i].wearTime;
          }
        }
        return {
          'day': DateFormat.E().format(weekDay),
          'weartime': totalWeartime,
        };
      },
    ).toList();
  }

  double get maxWeartime {
    return groupedWearTimes.fold(0.0, (sum, element) {
      return sum + element['weartime'];
    });
  }

  void addSample() {
    final newWt = Compliance(
      wearTime: 1.0,
      date: DateTime.now(),
    );
    _samples.insert(0, newWt);
    notifyListeners();
  }
}
