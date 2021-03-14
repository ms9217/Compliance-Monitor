import 'package:flutter/material.dart';

import './models/user.dart';
import './models/compliance.dart';

 const DUMMY_USER = User(
  name: 'User',
  id: 'u1',
  recommendedWearTime: 15,
);

var DUMMY_COMPLIANCE = Compliance(
  date: DateTime.now(),
  strapStrain: 12.1,
  wearTime: 10,
  temp: 27.2,
);
