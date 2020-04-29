import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spyfall/models/game.dart';
import 'package:spyfall/pages/game_pages/button_provider.dart';
import 'package:spyfall/pages/game_pages/listviews/player_list.dart';
import 'package:spyfall/services/database.dart';
import 'package:provider/provider.dart';

class NewGame extends StatefulWidget {
  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {

  final CollectionReference activeGamesCollection = Firestore.instance.collection('activeGames');

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
          backgroundColor: Color(0xFF947C6A),
          title: Text('Spyfall'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Access Code: $accessCode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.white,
                  )
                ),
                SizedBox(height:20.0),
                Text(
                  'Joined Players',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  )
                ),
                PlayerList(),
              ],
            ),
          ),
        ),
        floatingActionButton: ButtonProvider(creatorID, deviceID),
      ),
    );
  }
}