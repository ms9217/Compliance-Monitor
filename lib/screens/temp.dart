import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

import '../models/bt.dart';

class TempConnect extends StatefulWidget {
  static const routeName = '/tempconnect';

  final String title = 'Connect your device';

  @override
  _TempConnectState createState() => _TempConnectState();
}

class _TempConnectState extends State<TempConnect> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final bt = Provider.of<Bt>(context, listen: false);
      bt.initialise();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bt = Provider.of<Bt>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: bt.buildView(),
    );
  }
}
