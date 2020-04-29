import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/game.dart';
import 'package:spyfall/pages/game_pages/listviews/player_tile.dart';

class PlayerList extends StatefulWidget {

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final activeGame = Provider.of<Game>(context);
    if(activeGame == null){
      print('activeGame was null');
      return Container();
    }
    else{
      print('activeGame was not null');
      List<String> players = activeGame.getListOfPlayers();
      players.sort((a, b) => a.toString().compareTo(b.toString()));
      return Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: ((size.width*3) / size.height),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: List.generate(players.length, (index) => PlayerTile(player: players[index], active: activeGame.getIsActive()))
        ),
      );
    }
  }
}