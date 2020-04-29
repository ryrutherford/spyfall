import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/game.dart';
import 'package:spyfall/pages/game_pages/active_game_pages/creator_view.dart';
import 'package:spyfall/pages/game_pages/active_game_pages/noncreator_view.dart';
import 'package:spyfall/services/database.dart';

class ActiveGame extends StatefulWidget {
  @override
  _ActiveGameState createState() => _ActiveGameState();
}

class _ActiveGameState extends State<ActiveGame> {

  final CollectionReference activeGamesCollection = Firestore.instance.collection('activeGames');


  /*
  If the deviceID==spyID then we display:
    - Current Location: Unknown => You are the spy
    - A list of the possible locations "Potential Locations" (tapping on a location will darken the tile)
    - A Guess the location button
    - A floating button that displays the score
  If the deviceID!=spyID then we display:
    - Current location: x => you are not the spy
    - A list of the other users "Potential Spies" (tapping on a user's name will darken the tile)
    - A Guess the Spy Button
    - A floating button that displays the score
  When the round ends: we display a loading screen and load the next round (if there are no unusedlocations left => notify the user display Leave Game Button)
  */
  @override
  Widget build(BuildContext context) {

    Map passedParams = ModalRoute.of(context).settings.arguments;
    String creatorID = passedParams['creatorID'];
    int accessCode = passedParams['accessCode'];
    String deviceID = passedParams['deviceID'];


    return StreamProvider<Game>.value(
      value: DatabaseService(creatorID).activeGame,
      child: Scaffold(
        backgroundColor: Color(0xFF2F2C3D),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home'))
          ),
          backgroundColor: Color(0xFF947C6A),
          title: Text('Spyfall'),
          centerTitle: true,
        ),
        body: creatorID == deviceID ?
        //view to be displayed to creator
        CreatorView(deviceID)
        :
        //view to be displayed to noncreator
        NonCreatorView(deviceID),
      ),
    );
  }
}