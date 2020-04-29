import 'package:flutter/material.dart';

class PlayerTile extends StatefulWidget {

  final String player;
  final bool active;
  PlayerTile({this.player, this.active});

  @override
  _PlayerTileState createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {

  bool changeColour;

  @override
  void initState() {
    super.initState();
    changeColour = false;
  }

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
        color: changeColour ? Color(0xFF3b312a) : Color(0xFF947C6A),
        child: ListTile(
          title: Text(widget.player, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
          onTap: widget.active ? () {
            setState(() {
              changeColour = !changeColour;
            });
          }
          :
          null
        ),
      ),
    );
  }
}