import 'package:flutter/material.dart';

class ActiveGame extends StatefulWidget {
  @override
  _ActiveGameState createState() => _ActiveGameState();
}

class _ActiveGameState extends State<ActiveGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F2C3D),
      appBar: AppBar(
        backgroundColor: Color(0xFF947C6A),
        title: Text('New Game'),
        centerTitle: true,
      ),
    );
  }
}