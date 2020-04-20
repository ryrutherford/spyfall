import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class LocationTile extends StatefulWidget {

  //location is the name of the location
  final String location;
  //active indicates whether this location is part of the active or inactive locations
  final bool active;
  //deviceID is the unique identifier of this user
  final String deviceID;
  //activeLocations is a list of all the activeLocations
  List<String> activeLocations;
  //inactiveLocations is a list of all the inactiveLocations
  List<String> inactiveLocations;
  //the callback is to be called when a locations active status changes or a location is deleted
  //the callback will change the state in the parent widget (LocationsBottomsheet) causing the tiles to be rebuilt
  //this means the tile will be removed from the current view as soon as it is deleted or changed
  final Function callback;
  
  LocationTile(this.location, this.active, this.deviceID, this.activeLocations, this.inactiveLocations, this.callback);

  @override
  _LocationTileState createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {

  @override
  Widget build(BuildContext context) {
    final CollectionReference userLocationsCollection = Firestore.instance.collection('userLocations');
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(8.0),
        color: Color(0xFF947C6A),
        child: ListTile(
          onTap: () async {
            if(this.widget.active){
              widget.activeLocations.remove(this.widget.location);
              widget.inactiveLocations.add(this.widget.location);
            }
            else{
              widget.activeLocations.add(this.widget.location);
              widget.inactiveLocations.remove(this.widget.location);
            }
            await userLocationsCollection.document(this.widget.deviceID).updateData({
              "activeLocations": widget.activeLocations,
              "inactiveLocations": widget.inactiveLocations
            });
            widget.callback(Uuid());
          },
          onLongPress: () async {
            if(this.widget.active){
              widget.activeLocations.remove(this.widget.location);
              await userLocationsCollection.document(this.widget.deviceID).updateData({
                "activeLocations": widget.activeLocations,
              });
            }
            else{
              widget.inactiveLocations.remove(this.widget.location);
              await userLocationsCollection.document(this.widget.deviceID).updateData({
                "inactiveLocations": widget.inactiveLocations,
              });
            }
            widget.callback(Uuid());
          },
          title: Text(this.widget.location, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}