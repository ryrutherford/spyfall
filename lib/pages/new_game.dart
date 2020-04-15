import 'package:flutter/material.dart';
import 'dart:math';

class NewGame extends StatefulWidget {
  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  
  Future<int> accessCode;

  Future<int> generateAccessCode() async {
    //int uniqueCode = await firebase.get(all access codes)
    var rand = Random();
    int uniqueCode = (100000 +  rand.nextDouble() * 900000).floor();
    return uniqueCode;
  }

  @override
  void initState() {
    accessCode = generateAccessCode();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F2C3D),
      appBar: AppBar(
        backgroundColor: Color(0xFF947C6A),
        title: Text('Spyfall'),
        centerTitle: true,
      ),
    );
  }
}