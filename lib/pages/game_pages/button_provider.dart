import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/game.dart';

class ButtonProvider extends StatefulWidget {

  final String creatorID;
  final String deviceID;

  const ButtonProvider(this.creatorID, this.deviceID);

  @override
  _ButtonProviderState createState() => _ButtonProviderState();
}

class _ButtonProviderState extends State<ButtonProvider> {

  final CollectionReference activeGamesCollection = Firestore.instance.collection('activeGames');

  void _updateGameDetails(Game gameDetails) async {
    
    //will be used to randomly select a variety of game details
    var rand = Random();

    //randomly choosing the spy
    List<String> playerIDs = gameDetails.getListOfPlayerIDs();
    int index = rand.nextInt(playerIDs.length);
    String spyID = playerIDs[index];

    //randomly choosing the location
    List<String> locations = gameDetails.getUnusedLocations();
    index = rand.nextInt(locations.length);
    String location = locations[index];
    //updating the locations to reflect that a location has been used
    locations.removeAt(index);

    //updating firestore to reflect the changes
    await activeGamesCollection.document(widget.creatorID).updateData({
      'currentLocation': location,
      'spyID': spyID,
      'unusedLocations': locations,
      'isActive': true
    });
  }

  @override
  Widget build(BuildContext context) {

    //the active game
    final Game activeGame = Provider.of<Game>(context);

    if(activeGame == null){
      //TODO: Handle error appropriately
      print('error, activeGame was null');
      return SizedBox(height:0.0);
    }

    final int numPlayers = activeGame.getListOfPlayers().length;

    //if there are between 4 and 10 players and the screen is being displayed to the game creator, a start game button will appear
    return numPlayers >= 4 && numPlayers <= 10 && widget.creatorID == widget.deviceID ? 
      FloatingActionButton(
        onPressed: () {
          _updateGameDetails(activeGame);
          Navigator.pushReplacementNamed(context, '/active_game', arguments: {
            'creatorID': widget.creatorID,
            'accessCode': activeGame.getAccessCode(),
            'deviceID': widget.deviceID,
          });
        },
        child: Text('Start', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF947C6A),
      )
      :
      //return an empty container
      Container(height: 0.0, width: 0.0);
  }
}