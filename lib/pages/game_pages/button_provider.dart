import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/game.dart';

class ButtonProvider extends StatefulWidget {

  final String creatorID;

  const ButtonProvider(this.creatorID);

  @override
  _ButtonProviderState createState() => _ButtonProviderState();
}

class _ButtonProviderState extends State<ButtonProvider> {
  @override
  Widget build(BuildContext context) {

    //the active game
    final activeGame = Provider.of<Game>(context);

    if(activeGame == null){
      //TODO: Handle error appropriately
      print('error, activeGame was null');
      return SizedBox(height:0.0);
    }

    final int numPlayers = activeGame.getListOfPlayers().length;

    //if there are between 4 and 10 players and the screen is being displayed to the game creator, a start game button will appear
    return numPlayers >= 4 && numPlayers <= 10 && activeGame.getCreatorID() == widget.creatorID ? 
      FloatingActionButton(
        onPressed: () async {

        },
        child: Text('Start', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF947C6A),
      )
      :
      //return an empty container
      Container(height: 0.0, width: 0.0);
  }
}