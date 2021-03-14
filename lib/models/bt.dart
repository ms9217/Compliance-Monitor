import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Bt with ChangeNotifier {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
  BluetoothDevice _connectedDevice;
  List<BluetoothService> _services;
  var selectedChar;

  _addDeviceTolist(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      devicesList.add(device);
      notifyListeners();
    }
  }

  initialise() {
    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    flutterBlue.startScan();
  }

  ListView _buildListViewOfDevices() {
    List<Container> containers = new List<Container>();
    for (BluetoothDevice device in devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.blue,
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  flutterBlue.stopScan();
                  try {
                    await device.connect();
                  } catch (e) {
                    if (e.code != 'already_connected') {
                      throw e;
                    }
                  } finally {
                    _services = await device.discoverServices();
                  }

                  _connectedDevice = device;
                  notifyListeners();
                },
              ),
              // FlatButton(
              //   color: Colors.blue,
              //   child: Text(
              //     'Disconnect',
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   onPressed: () async {
              //     //flutterBlue.stopScan();
              //     try {
              //       await device.disconnect();
              //     } catch (e) {
              //       if (e.code != 'already_disconnected') {
              //         throw e;
              //       }
              //     } finally {
              //       //_services = await device.discoverServices();
              //     }
              //     notifyListeners();
              //   },
              // ),
            ],
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  // void dataRead() async {
  //   // //notify
  //   // selectedChar.value.listen((value) {
  //   //   readValues[selectedChar.uuid] = value;
  //   //   notifyListeners();
  //   // });
  //   // await selectedChar.setNotifyValue(true);

  //   //read
  //   var sub = selectedChar.value.listen((value) {
  //     readValues[selectedChar.uuid] = value;
  //     notifyListeners();
  //   });
  //   await selectedChar.read();
  //   sub.cancel();
  //   notifyListeners();
  // }

  List<ButtonTheme> _buildReadNotifyButton(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = new List<ButtonTheme>();
    void notifyPress() async {
      characteristic.value.listen((value) {
        readValues[characteristic.uuid] = value;
      });
      await characteristic.setNotifyValue(true);
    }

    void stopNotifyPress() async {
      characteristic.value.listen((value) {
        readValues[characteristic.uuid] = value;
      });
      await characteristic.setNotifyValue(false);
    }

    void readPress() async {
      notifyPress();
      var sub = characteristic.value.listen((value) {
        readValues[characteristic.uuid] = value;
        notifyListeners();
      });
      await characteristic.read();
      sub.cancel();
    }

    if (characteristic.properties.read) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: RaisedButton(
              color: Colors.blue,
              child: Text('READ', style: TextStyle(color: Colors.white)),
              onPressed: readPress,
            ),
          ),
        ),
      );
    }

    // if (characteristic.properties.notify) {
    //   buttons.add(
    //     ButtonTheme(
    //       minWidth: 10,
    //       height: 20,
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 4),
    //         child: RaisedButton(
    //           child: Text('NOTIFY', style: TextStyle(color: Colors.white)),
    //           onPressed: notifyPress,
    //         ),
    //       ),
    //     ),
    //   );
    // }
    // }
    buttons.add(ButtonTheme(
      minWidth: 10,
      height: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: RaisedButton(
          child: Text('STOP READ', style: TextStyle(color: Colors.white)),
          onPressed: stopNotifyPress,
        ),
      ),
    ));

    return buttons;
  }

  ListView _buildConnectDeviceView() {
    List<Container> containers = new List<Container>();

    for (BluetoothService service in _services) {
      List<Widget> characteristicsWidget = new List<Widget>();

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.notify) {
          characteristicsWidget.add(
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(characteristic.uuid.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ..._buildReadNotifyButton(characteristic),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Value: ' +
                          readValues[characteristic.uuid].toString()),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          );
          //sentData = readValues[characteristic.uuid].toString();
          notifyListeners();
          //}
          selectedChar = characteristic;
          notifyListeners();
        }
        //if (selectedChar.properties.notify) {
        containers.add(
          Container(
            child: ExpansionTile(
                title: Text(service.uuid.toString()),
                children: characteristicsWidget),
          ),
        );
        //}
        //}
      }
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  bool check(String s) {
    if (s == null) {
      return false;
    }
    return s != null;
  }

  ListView _buildReaderView() {
    List<Container> containers = new List<Container>();

    for (BluetoothService service in _services) {
      List<Widget> characteristicsWidget = new List<Widget>();

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        String inVal = readValues[characteristic.uuid].toString();
        print(inVal);
        var data;
        var strainValues;
        String strap1;
        String strap2;
        String strap3;
        String strap4;
        if (isNumeric(inVal.substring(2, 3))) {
          data = inVal.substring(1, inVal.length - 1);

          var data1 = data.split(',');
          //integerVal = String.fromCharCode(int.parse(inVal.substring(1, 3)));
          //integerVal = inVal.substring(1, 3);

          strap1 = data1[0];
          strap2 = data1[1];
          strap3 = data1[2];
          strap4 = data1[3];
          notifyListeners();

          //strainValues[i] = '1';
        } else {
          strap1 = '0';
          strap2 = '2';
          strap3 = '3';
          strap4 = '4';
        }
        var integerVal = '';
        //if (inVal.substring(1, 3) == '52')

        if (characteristic.properties.notify) {
          characteristicsWidget.add(
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      // Row(
                      //   children: <Widget>[
                      //     // Text(characteristic.uuid.toString(),
                      //     //     style: TextStyle(fontWeight: FontWeight.bold)),
                      //   ],
                      // ),
                      Row(
                        children: <Widget>[
                          ..._buildReadNotifyButton(characteristic),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Value: ' + inVal,
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Column(children: [
                            Text(
                              'Strap 1 tightness:  $strap1', // + integerVal,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Strap 2 tightness:  $strap2', // + integerVal,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Strap 3 tightness:  $strap3', // + integerVal,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Strap 4 tightness:  $strap4', // + integerVal,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ])
                        ],
                      ),
                    ],
                  ),
                ),
                constraints: BoxConstraints(maxWidth: 300),
                padding: EdgeInsets.symmetric(
                  vertical: 60,
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
          );
          //sentData = readValues[characteristic.uuid].toString();
          notifyListeners();
        }
        selectedChar = characteristic;
        notifyListeners();
      }
      if (selectedChar.properties.notify) {
        containers.add(
          Container(
            child: Column(
              //Fit screen display widget
              children: [
                SizedBox(
                  height: 100,
                ),
                Column(
                  //title: Text(service.uuid.toString()),
                  //Strap tightness display widget
                  children: characteristicsWidget,
                ),
              ],
            ),
          ),
        );
      }
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  ListView buildReader() {
    return _buildReaderView();
  }

  // void buttonDisconnect() {
  //   _connectedDevice.disconnect();
  // }

  ListView buildView() {
    if (_connectedDevice != null) {
      return _buildConnectDeviceView();
    }
    return _buildListViewOfDevices();
  }
}
