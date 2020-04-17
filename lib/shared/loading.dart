import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {

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
}