import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Spyfall'),
          backgroundColor: Color(0xFF947C6A),
          centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF2F2C3D),
        child: Text(
          'Device Not Supported',
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        )
      ),
    );
  }
}