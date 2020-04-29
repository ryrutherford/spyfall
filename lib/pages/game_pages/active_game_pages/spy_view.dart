import 'package:flutter/material.dart';
import 'package:spyfall/pages/game_pages/listviews/location_list.dart';

class SpyView extends StatefulWidget {
  @override
  _SpyViewState createState() => _SpyViewState();
}

class _SpyViewState extends State<SpyView> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Current Location: ???',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.white,
              )
            ),
            SizedBox(height: 10.0),
            Text(
              'You are the spy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )
            ),
            SizedBox(height: 20.0),
            Text(
              'Potential Locations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )
            ),
            SizedBox(height: 10.0),
            LocationList(),
          ],
        )
      ),
    );
  }
}