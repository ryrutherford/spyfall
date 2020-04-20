import 'package:flutter/material.dart';
import 'package:spyfall/models/locations.dart';
import 'package:spyfall/pages/home/locations/location_tile.dart';

class LocationsBottomsheet extends StatefulWidget {
  final Locations userLocations;
  //if active = true then we show the active locations, otherwise we show the inactive locations
  final bool active;
  final String deviceID;

  const LocationsBottomsheet(this.userLocations, this.active, this.deviceID);

  @override
  _LocationsBottomsheetState createState() => _LocationsBottomsheetState();
}

class _LocationsBottomsheetState extends State<LocationsBottomsheet> {

  //the _rebuildState variable exists to be called by the LocationTile widget when a location is deleted or its active status is changed
  var _rebuildState;

  @override
  Widget build(BuildContext context) {
    
    List<String> activeLocations = [];
    List<String> inactiveLocations = [];

    //size of display area
    var size = MediaQuery.of(context).size;

    if(widget.userLocations != null){
      activeLocations = widget.userLocations.getActiveLocations();
      inactiveLocations = widget.userLocations.getInactiveLocations();
    }
    //if the Show Active Locations button was selected, the active locations will be displayed
    //if the Show Inactive Locations button was selected, the inactive locations will be displayed
    return widget.active ? Column(
      children: <Widget>[
        Text(
          'Active Locations',
          style: TextStyle(
            color: Colors.white,
          )
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: ((size.width) / size.height),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: List.generate(activeLocations.length, (index) => LocationTile(activeLocations[index], true, widget.deviceID, activeLocations, inactiveLocations, (val) => setState(() => _rebuildState = val)))
          ),
        ),
      ],
    )
    : 
    Column(
      children: <Widget>[
        Text(
          'Inactive Locations',
          style: TextStyle(
            color: Colors.white,
          )
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: ((size.width) / size.height),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: List.generate(inactiveLocations.length, (index) => LocationTile(inactiveLocations[index], false, widget.deviceID, activeLocations, inactiveLocations, (val) => setState(() => _rebuildState = val)))
          ),
        ),
      ],
    );
  }
}