import 'package:flutter/material.dart';

class JoinGame extends StatefulWidget {
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F2C3D),
      appBar: AppBar(
        backgroundColor: Color(0xFF947C6A),
        title: Text('Spyfall'),
        centerTitle: true,
      ),
      body: Center(
        child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width/2.5,
          child: FlatButton(
            onPressed: () {},
            color: Color(0xFF947C6A),
            child: Text(
              'Join Game', 
               style: TextStyle(
                color: Colors.white,
               )
            ),
          ),
        ),
      ),
    );
  }
}