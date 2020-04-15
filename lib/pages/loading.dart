import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:device_info/device_info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:flutter/services.dart';

class Loading extends StatelessWidget {

    void _getID(BuildContext context) async {
    //the device id identifies a user uniquely
      String deviceID;
      try {
        deviceID = await FlutterUdid.consistentUdid;
        Timer(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/home', arguments: {
          'deviceID': deviceID,
        }));
      } on PlatformException {
        Timer(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/home', arguments: {
          'deviceIDErrorMSG': 'Device Not Supported',
        }));
      }
    }

  @override
  Widget build(BuildContext context) {
    _getID(context);
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
/*
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void _getID() async {
    //the device id identifies a user uniquely
    String deviceID;
    try {
      deviceID = await FlutterUdid.udid;
      Timer(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/home', arguments: {
        'deviceID': deviceID,
      }));
    } on PlatformException {
      deviceID = 'Failed to get deviceID';
      Timer(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/home', arguments: {
        'deviceIDErrorMSG': 'Device Not Supported',
      }));
    }
    /*
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceID = iosDeviceInfo.identifierForVendor; // unique ID on iOS
      //passing the data to the home page
      Timer(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/home', arguments: {
        'deviceID': deviceID,
      }));
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceID = androidDeviceInfo.androidId; // unique ID on Android
      //passing the data to the home page
      Timer(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/home', arguments: {
        'deviceID': deviceID,
      }));
    }*/
  }

  @override
  void initState() {
    super.initState();
    //making the async call to get the deviceID
    WidgetsBinding.instance.addPostFrameCallback((_) {_getID();});
  }

  @override
  Widget build(BuildContext context) {
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
}*/