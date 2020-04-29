import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/game.dart';
import 'package:spyfall/pages/game_pages/active_game_pages/nonspy_view.dart';
import 'package:spyfall/pages/game_pages/active_game_pages/spy_view.dart';

class CreatorView extends StatefulWidget {
  
  final String deviceID;
  const CreatorView(this.deviceID);

  @override
  _CreatorViewState createState() => _CreatorViewState();
}

class _CreatorViewState extends State<CreatorView> {

  final CollectionReference activeGamesCollection = Firestore.instance.collection('activeGames');
  String _errorMsg = '';
  
  @override
  Widget build(BuildContext context) {

    final activeGame = Provider.of<Game>(context);

    void _newRound() async {
      //will be used to randomly select a variety of game details
      var rand = Random();

      //randomly choosing the spy
      List<String> playerIDs = activeGame.getListOfPlayerIDs();
      int index = rand.nextInt(playerIDs.length);
      String spyID = playerIDs[index];

      //making sure we don't choose the same spy as the last game
      while(spyID == activeGame.getSpyID()){
        index = rand.nextInt(playerIDs.length);
        spyID = playerIDs[index];
      }

      //randomly choosing the location
      List<String> locations = activeGame.getUnusedLocations();
      if(locations.length != 0){
        index = rand.nextInt(locations.length);
        String location = locations[index];
        //updating the locations to reflect that a location has been used
        locations.removeAt(index);

        //updating firestore to reflect the changes
        await activeGamesCollection.document(widget.deviceID).updateData({
          'currentLocation': location,
          'spyID': spyID,
          'unusedLocations': locations,
        });
      }
      else{
        setState(() => _errorMsg = 'There are no locations left, you must start a new game.');
      }
    }
    
    if(activeGame == null){
      return Container(height: 0.0);
    }
    else{
      return Column(
        children: <Widget>[
          Expanded(child: activeGame.getSpyID() == widget.deviceID ? SpyView() : NonSpyView()),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width/2.5,
            child: RaisedButton(
              onPressed: _errorMsg == '' ? () => _newRound() : null,
              color: Color(0xFF947C6A),
              child: Text(
                'New Round', 
                style: TextStyle(
                  color: Colors.white,
                )
              ),
            ),
          ),
          Text(this._errorMsg, style: TextStyle(color: Colors.red), textAlign: TextAlign.center,),
          SizedBox(height:20.0),
        ],
      );
    }
  }
}