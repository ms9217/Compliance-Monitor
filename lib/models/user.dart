import 'package:flutter/material.dart';

class User {
  final String name;
  final String id;
  final double recommendedWearTime;

  const User({
    @required this.name,
    @required this.id,
    this.recommendedWearTime,
  });
}
