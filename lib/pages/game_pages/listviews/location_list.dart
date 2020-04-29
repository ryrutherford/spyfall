import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/game.dart';
import 'package:spyfall/pages/game_pages/listviews/game_location_tile.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
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
      List<String> locations = activeGame.getUnusedLocations();
      locations.add(activeGame.getCurrentLocation());
      locations.sort((a, b) => a.toString().compareTo(b.toString()));
      return Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: ((size.width*3) / size.height),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: List.generate(locations.length, (index) => GameLocationTile(location: locations[index]))
        ),
      );
    }
  }
}