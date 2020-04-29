import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/game.dart';
import 'package:spyfall/pages/game_pages/active_game_pages/nonspy_view.dart';
import 'package:spyfall/pages/game_pages/active_game_pages/spy_view.dart';

class NonCreatorView extends StatefulWidget {

  final String deviceID;
  const NonCreatorView(this.deviceID);

  @override
  _NonCreatorViewState createState() => _NonCreatorViewState();
}

class _NonCreatorViewState extends State<NonCreatorView> {
  @override
  Widget build(BuildContext context) {
    
    final activeGame = Provider.of<Game>(context);
    
    if(activeGame == null){
      return Container(height: 0.0);
    }
    else{
      return activeGame.getSpyID() == widget.deviceID ? SpyView() : NonSpyView(); 
    }
  }
}