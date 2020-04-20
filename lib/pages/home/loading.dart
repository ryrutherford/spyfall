import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:spyfall/shared/constants.dart';

class Loading extends StatelessWidget {

  void _getIDAndLocations(BuildContext context) async {
  
    //the device id identifies a user uniquely
    String deviceID;
    
    
    List<dynamic> inactiveLocations = [];
    List<dynamic> activeLocations = defaultLocations;

    try {
      //getting the deviceID
      deviceID = await FlutterUdid.consistentUdid;

      //setting the default locations for the user. if they have added custom locations, they won't be overwritten because merge: true
      CollectionReference userLocations = Firestore.instance.collection('userLocations');
      //checking if the document exists
      var document = await userLocations.document(deviceID).get();
      if(document.data == null){
        await userLocations.document(deviceID).setData({
          'activeLocations': activeLocations,
          'inactiveLocations': inactiveLocations,
          'remindUser': true,
        });
      }
      else{
        await userLocations.document(deviceID).get().then((dS) {
            activeLocations = dS.data['activeLocations'];
            inactiveLocations = dS.data['inactiveLocations'];
          }
        );
      }

      Timer(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/home', arguments: {
        'deviceID': deviceID,
        'activeLocations': activeLocations,
        'inactiveLocations': inactiveLocations,
      }));

    } on PlatformException {
      //TODO: make app unusable if device is not supported
      Timer(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/home', arguments: {
        'deviceIDErrorMSG': 'Device Not Supported',
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    _getIDAndLocations(context);
    return Scaffold(
      backgroundColor: Color(0xFF2F2C3D),
      body: Center(
          child: SpinKitFoldingCube(
            color: Color(0xFF947C6A),
            size: 80.0,
          ),
      )
    );
  }
}