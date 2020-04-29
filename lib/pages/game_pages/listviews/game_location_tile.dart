import 'package:flutter/material.dart';

class GameLocationTile extends StatefulWidget {

  final String location;
  GameLocationTile({this.location});

  @override
  _GameLocationTileState createState() => _GameLocationTileState();
}

class _GameLocationTileState extends State<GameLocationTile> {

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
          title: Text(widget.location, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
          onTap: () {
            setState(() {
              changeColour = !changeColour;
            });
          },
        ),
      ),
    );
  }
}