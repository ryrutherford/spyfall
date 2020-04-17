import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {

  final String player;
  PlayerTile({this.player});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(8.0),
        color: Color(0xFF947C6A),
        child: ListTile(
          title: Text(this.player, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}