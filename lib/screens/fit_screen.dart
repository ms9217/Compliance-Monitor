import '../models/bt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FitScreen extends StatefulWidget {
  static const routeName = '/fit';

  @override
  _FitScreenState createState() => _FitScreenState();
}

class _FitScreenState extends State<FitScreen> {
  @override
  Widget build(BuildContext context) {
    final bt = Provider.of<Bt>(context);
    //var strainData = bt.sentData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Check your fit'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {} //=> bt.buttonDisconnect,
              )
        ],
      ),
      body: bt.buildReader()
      //Center(
      //   child: Column(
      //     children: <Widget>[
      //       SizedBox(
      //         height: 100,
      //       ),
      //       Container(
      //         constraints: BoxConstraints(maxWidth: 300),
      //         padding: EdgeInsets.symmetric(
      //           vertical: 30,
      //           horizontal: 30,
      //         ),
      //         child: Column(
      //           children: [
      //             Container(
      //               child: Text(
      //                 'Strap tightness:  ' + strainData,
      //                 style: TextStyle(
      //                   fontSize: 20,
      //                 ),
      //               ),
      //               alignment: Alignment.topLeft,
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Text(
      //               'Upper strap too loose',
      //               style: TextStyle(
      //                 color: Colors.orange,
      //                 fontSize: 20,
      //               ),
      //             ),
      //           ],
      //         ),
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             width: 3,
      //             color: Colors.grey,
      //           ),
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(15),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 30,
      //       ),
      //       Container(
      //         constraints: BoxConstraints(maxWidth: 300),
      //         padding: EdgeInsets.symmetric(
      //           vertical: 30,
      //           horizontal: 30,
      //         ),
      //         child: Column(
      //           children: [
      //             Container(
      //               child: Text(
      //                 'Skin temperature:',
      //                 style: TextStyle(
      //                   fontSize: 20,
      //                 ),
      //               ),
      //               alignment: Alignment.topLeft,
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Text(
      //               'Good',
      //               style: TextStyle(
      //                 color: Colors.lightGreen,
      //                 fontSize: 20,
      //               ),
      //             ),
      //           ],
      //         ),
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             width: 3,
      //             color: Colors.grey,
      //           ),
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(15),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
