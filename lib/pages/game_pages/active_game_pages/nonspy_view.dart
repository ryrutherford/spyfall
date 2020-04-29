import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/game.dart';
import 'package:spyfall/pages/game_pages/listviews/player_list.dart';

class NonSpyView extends StatefulWidget {
  @override
  _NonSpyViewState createState() => _NonSpyViewState();
}

class _NonSpyViewState extends State<NonSpyView> {
  @override
  Widget build(BuildContext context) {

    final activeGame = Provider.of<Game>(context);
    if(activeGame == null){
      return Container();
    }
    else{
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Current Location: ${activeGame.getCurrentLocation()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                'You are not the spy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                )
              ),
              SizedBox(height: 20.0),
              Text(
                'Potential Spies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                )
              ),
              SizedBox(height: 10.0),
              PlayerList(),
            ],
          )
        ),
      );
    }
  }
}