import 'package:flutter/material.dart';

class Compliance {
  final DateTime date;
  final double wearTime;
  final double strapStrain;
  final double temp;

  const Compliance({
    @required this.date,
    @required this.wearTime,
    this.strapStrain,
    this.temp,
  });
}
